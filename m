Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbREMSob>; Sun, 13 May 2001 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262835AbREMSoV>; Sun, 13 May 2001 14:44:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33799 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262329AbREMSoF>; Sun, 13 May 2001 14:44:05 -0400
Subject: Re: [PATCH] drivers/telephony/phonedev.c (brings this code up to date with Quicknet CVS)
To: david@blue-labs.org (David Ford)
Date: Sun, 13 May 2001 19:37:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        eokerson@quicknet.net (Ed Okerson)
In-Reply-To: <3AFEC0FB.8080705@blue-labs.org> from "David Ford" at May 13, 2001 10:14:35 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z0kM-0006oH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alrighty.  That eliminates the patch.  I'll rewrite the ixj.c according 
> to this.  ixj.c will be a large patch due to the numerous revisions, I 

Im much less worried about having 2.2/2.4 version code in the ixj driver
itself. Quicknet have to maintain that for 2.2/2.4 and I dont want to make
their life that needlessly painful

> don't know how well it can be broken up into small pieces.  Do you want 
> small pieces still?  The ChangeLog shows all the fixes for the 
> revisions.  There have been 68 revisions since the version listed in the 
> kernel's tree.

See what you can do - if its too hard we may just have to do it the hard way

