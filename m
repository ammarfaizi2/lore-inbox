Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267246AbUBMWdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267257AbUBMWdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:33:03 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:34693 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S267246AbUBMWdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:33:01 -0500
Subject: Re: what is the best 2.6.2 kernel code?
From: Stephen Smoogen <smoogen@lanl.gov>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
References: <0A78D025ACD7C24F84BD52449D8505A15A80CF@wcosmb01.cos.agilent.com>
Content-Type: text/plain
Organization: CCN-2 ESM/SSC
Message-Id: <1076711578.3952.25.camel@smoogen2.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 15:32:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-13 at 15:24, yiding_wang@agilent.com wrote:
> I downloaded kernel linux-2.6.2.tar.gz and patch-2.6.2.bz2  from kernel source.  Both files are dated 03-Feb.-2004.   
> 

The patch file is used for patching linux-2.6.1 -> 2.6.2 and not for
anything else. Basically you should probably do a 

/bin/rm linux-2.6.2
tar xzvf linux-2.6.2.tar.gz
cd linux-2.6.2
and follow the instructions on compiling from the README.

-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- So shines a good deed in a weary world. = Willy Wonka --

