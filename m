Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRKZK47>; Mon, 26 Nov 2001 05:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280792AbRKZK4u>; Mon, 26 Nov 2001 05:56:50 -0500
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:58256 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S280612AbRKZK4f>; Mon, 26 Nov 2001 05:56:35 -0500
Message-ID: <3C021FAF.ABAD279E@cisco.com>
Date: Mon, 26 Nov 2001 16:25:43 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question on ioctl collisions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a way in the kernel to detect ioctl conflicts
at runtime ? This could deter people from using the
same number while registering.

thanks
Manik

