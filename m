Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVC0HlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVC0HlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 02:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVC0HlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 02:41:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63949 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261444AbVC0HlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 02:41:01 -0500
Message-ID: <42465EE5.4020306@colorfullife.com>
Date: Sun, 27 Mar 2005 09:21:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee wrote:

>> What ever gave you the impression that it was legal to create a
>> "Proprietry" kernel driver for Linux in the first place.
>
>The fact that Nvidia and ATI get away with it?
>
>  
>
The didn't write a Linux driver. They have multi-platform drivers that 
work among other OS on Linux, too.
E.g. the Nvidia binary ethernet driver can be used on both Linux and 
FreeBSD, and I've heard that the .o file contains Windows specific 
functions, thus it appears that Nvidia compiles the driver for all three 
OS from one common code base.
At least for me, such a driver cannot be considered to be derived from 
Linux, thus a non-GPL license is ok.
OTHO a driver that was written for Linux is in my opinion derived from 
Linux and thus the GPL is mandatory.

Just speaking for myself,
--
    Manfred
