Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSBRRhW>; Mon, 18 Feb 2002 12:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293359AbSBRRfO>; Mon, 18 Feb 2002 12:35:14 -0500
Received: from web14908.mail.yahoo.com ([216.136.225.60]:37391 "HELO
	web14908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S291043AbSBRRcn>; Mon, 18 Feb 2002 12:32:43 -0500
Message-ID: <20020218173242.44249.qmail@web14908.mail.yahoo.com>
Date: Mon, 18 Feb 2002 12:32:42 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Communication between two kernel modules
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, how can I call some kind of APIs from kernel mode,
such as open, ioctl and close? Because I need to use
some services of another kernel module from my kernel
module and I have no source code of the module which
provides the services. Now I can only access the
module in user space using the open, ioctl and close
APIs. Can I do the same thing in my kernel module?
Thanks.

Michael

______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
