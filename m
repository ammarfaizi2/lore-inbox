Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUBDL0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUBDL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:26:11 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:61139 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262050AbUBDL0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:26:07 -0500
Date: Wed, 04 Feb 2004 20:26:02 +0900 (JST)
Message-Id: <20040204.202602.70222883.marc@labs.fujitsu.com>
To: woody@jf.intel.com, sean.hefty@intel.com, hozer@hozed.org,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the
 linux kernel
From: Masanori ITOH <marc@labs.fujitsu.com>
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3664@orsmsx410.jf.intel.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3664@orsmsx410.jf.intel.com>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert, Sean,

Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3664@orsmsx410.jf.intel.com>
> Hi Masonori, 
> 
> I think that Sean has already pushed the code changes for 2.6 for 
> complib, IBAL, and SDP.  As I stated before, we have yet to test it on
> 2.6,
> but it should now compile. Let us know if you have any issues.

Currently, it doesn't seem to be available for 'bk pull', but
I will check it out as soon as it becomes public.

http://infiniband.bkbits.net:8080/iba/ChangeSet@-7d?nav=index.html
----
|Linux InfiniBand(tm) Project 
|-----------------------------------------------------------------------------
|ChangeSet Summaries 
|Age      Author   Rev   Comments 
|35 hours ardavis  1.221 878599 SDP fix for faster rejected connect requests.  
|6 days   jlcoffma 1.220 Fix for SourceForge bug number 880274 for build on the Linux 2.6kernel base. 

Thanks and stay tuned, :)
Masanori

---
Masanori ITOH  Grid Computing & Bioinformatics Lab., Fujitsu Labs. LTD.
               e-mail: marc@labs.fujitsu.com
               phone: +81-44-754-2628 (extension: 7112-6227)
               FingerPrint: 55AF C562 E415 FB1A 8A3A  35D1 AB40 8A9D B8B1 99F8

