Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVCNLRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVCNLRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVCNLRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:17:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:43461 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261586AbVCNLRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:17:33 -0500
Date: Mon, 14 Mar 2005 12:18:52 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, Domen Puncer <domen@coderock.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-cifs-client@lists.samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       samba-technical@lists.samba.org
Subject: Re: [PATCH][-mm][1/2] cifs: whitespace cleanups for file.c
In-Reply-To: <OF4C53518E.FBC70B15-ON87256FC4.00252AB1-86256FC4.00257AE2@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0503141211120.2534@dragon.hyggekrogen.localhost>
References: <OF4C53518E.FBC70B15-ON87256FC4.00252AB1-86256FC4.00257AE2@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Steven French wrote:

> 
> > Here's the first of two patches with cleanups for fs/cifs/file.c
> The patch looks safe enough but I can not get the patch to apply (pattch
> always claims it is malformed) - whichever email clients I received it
> from probably because of wrap at 80 columns or some conversion that
> occurred in the email text of the patch, although evolution email client
> also had problems with it being to big to cut and paste (but even trying
> it in smaller chunks I could not get it to apply). If you could resend
> it as a file that would be helpful.
> 
I just send it to you as an attachment in private email. I'd rather not 
resend that big a file to the lists if not needed. 

I've also put the patches online here :  

http://www.linuxtux.org/~juhl/fs_cifs_file-whitespace-cleanups-part-1.patch
http://www.linuxtux.org/~juhl/fs_cifs_file-whitespace-cleanups-part-2-and_cifs_open-rework.patch

They won't live forever at that location, but I can leave them there for a 
few weeks at least.


-- 
Jesper Juhl


