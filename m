Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281912AbRLAWWf>; Sat, 1 Dec 2001 17:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281914AbRLAWWZ>; Sat, 1 Dec 2001 17:22:25 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:9477 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S281912AbRLAWWQ>; Sat, 1 Dec 2001 17:22:16 -0500
Message-ID: <71714C04806CD5119352009027289217022C402D@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: RE: Incremental prepatches
Date: Sat, 1 Dec 2001 16:22:04 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have created a robot on kernel.org which makes incremental 
> prepatches 
> available.  It looks for standard-named prepatches in the 
> /pub/linux/kernel/v*.*/testing directories, and creates 
> incrementals in 
> the corresponding /pub/linux/kernel/v*.*/testing/incr directory.

Fantastic!  I was working on something similar in my spare time too, but it
wasn't complete yet.  Good job!
Would you be interested in setting up a kdist-like list to email out the
changelog, diffstat, and incremental patch too as a product of the patch
generation script?  That would increase the usefulness of comments like
"Alan - much merging" in the changelogs.  Also, a script to update a web
page ala www.bzimage.org would make patch browsing really easy.  I volunteer
to help if you like.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#1 US Linux Server provider with 24% (IDC Sept 2001)
#2 Worldwide Linux Server provider with 17% (IDC Sept 2001)
#3 Unix provider with 18% in the US (Dataquest)!
