Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbTCLDiW>; Tue, 11 Mar 2003 22:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbTCLDiW>; Tue, 11 Mar 2003 22:38:22 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:41610
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S263011AbTCLDiU>; Tue, 11 Mar 2003 22:38:20 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Date: Tue, 11 Mar 2003 21:49:04 -0600
User-Agent: KMail/1.5
References: <200303112055.31854.scott-kernel@thomasons.org> <15982.43897.703221.456961@notabene.cse.unsw.edu.au>
In-Reply-To: <15982.43897.703221.456961@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303112149.04144.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 March 2003 09:37 pm, you wrote:
> raid0 doesn't really work well in 2.5 yet.... as you have
> noticed.
>
> We really need to grab the bio splitting code out of md/dm.c
> and use it to split bios that are too big or that cross device
> boundaries.
>
> any volunteers??
>
> NeilBrown

Given all the grief I've encountered with ALSA, SCSI emulation, 
other stuff, and now RAID 0, I would certainly say that the 
spelling corrections may have been a little premature. It 
doesn't feel ready for 2.6 to me :(
---scott

