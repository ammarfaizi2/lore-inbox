Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUAVEdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 23:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbUAVEdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 23:33:08 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:39312 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266076AbUAVEdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 23:33:06 -0500
Message-ID: <400F527B.3070505@earthlink.net>
Date: Wed, 21 Jan 2004 23:32:59 -0500
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc1
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running RH9 with the latest kernel and get the following when I try 
to use rpm:
rpm -qa
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily 
unavailable (11)
error: cannot open Packages database in /var/lib/rpm
no packages

any ideas?

Thanks,
Steve


