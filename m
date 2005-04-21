Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVDULbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVDULbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDULbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:31:52 -0400
Received: from viking.sophos.com ([194.203.134.132]:11536 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261318AbVDULaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:30:11 -0400
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/04/2005 12:30:03,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/04/2005 12:30:03,
	Serialize complete at 21/04/2005 12:30:03,
	S/MIME Sign failed at 21/04/2005 12:30:03: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 21/04/2005 12:30:07,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 21/04/2005 12:30:07,
	Serialize complete at 21/04/2005 12:30:07,
	S/MIME Sign failed at 21/04/2005 12:30:07: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 21/04/2005 12:30:10,
	Serialize complete at 21/04/2005 12:30:10
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFD632A3BF.A81F7157-ON80256FEA.003F0182-80256FEA.003F2EB2@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Thu, 21 Apr 2005 12:30:07 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2005 12:13:46 linux-kernel-owner wrote:

>Without this patch, Linux provokes emergency disk shutdowns and
>similar nastiness. It was in SuSE kernels for some time, IIRC.

OMG! And I did try to raise that issue 10 months ago, see below:

http://www.ussg.iu.edu/hypermail/linux/kernel/0406.0/0242.html


