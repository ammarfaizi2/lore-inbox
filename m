Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVJVRji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVJVRji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJVRji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:39:38 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:15969 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751366AbVJVRjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:39:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F92f7tde0erbUnafVPB34eQoEmqvWErgqwl1xCF4EY9bImbfwHtUvW8p6k7iFstyFza91DOLpyfDhHJ3Cwva9zJF+RniCHs6NEgsou1o+0DZOSPZ4ppqcjCXFbkMYMgFBaOjSanTF/ICFSkXb42zbUPmivVV7gcOg0XXmVsb56Q=  ;
Message-ID: <20051022173936.26998.qmail@web31807.mail.mud.yahoo.com>
Date: Sat, 22 Oct 2005 10:39:36 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attachedPHYs)
To: David Lang <david.lang@digitalinsight.com>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0510220357250.4997@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Lang <david.lang@digitalinsight.com> wrote:
> Stefan, what you and Luben are missing is that big-bang changes like you 
> are proposing are simply not acceptable anymore.

Take a look at the link below, working SAS code with the current
kernel.  No one is trying to produce big-bang changes.  This is what
Jeff want's you to believe that I'm trying to do -- this is part of his
political game and FUD and apparently he's succeeding.

I repeat: no on is trying to produce a new "big-bang changes" as you
call them. See the working code in the link at my sig.  This is
_current_ Linus's tree with SAS Stack in it.

Don't yield to the FUD.

> This is what Jeff is trying to tell you. you can't just produce an 
> entirely new SCSI subsystem and drop it into the kernel one day, you can 

No, this is what he wants you to believe that I'm trying to do.  This is what
people start doing when they loose on technological ground.  Do not
yield to the FUD and politics.  See the working code of current Linus's tree
with SAS in it in my sig link.

I repeat, no one is trying to replace anything or throw anything out.
This is just FUD and politics which Jeff is spreading because he's got
an agenda in convincing certain people certain things.

See the working SAS code in the link below -- current Linus' tree with
SAS in it.  Soon enough it would contain SDI back-end and then HP and LSI
would be able to plug right in, and I think there's an engineer out there
who's already implemented a front end.

    Luben


-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
