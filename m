Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRLAOkv>; Sat, 1 Dec 2001 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284119AbRLAOkk>; Sat, 1 Dec 2001 09:40:40 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:33108 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S284118AbRLAOkd>; Sat, 1 Dec 2001 09:40:33 -0500
Date: Sat, 1 Dec 2001 15:06:45 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-preX version ..
Message-ID: <20011201140645.GA2957@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0112011517490.16903-100000@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0112011517490.16903-100000@linux.kappa.ro>
User-Agent: Mutt/1.3.24-current-20011201i (Linux 2.5.1-pre1 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Dec 01 2001, Teodor Iacob wrote:

> It seems like in the pre1 or pre2 patch of the kernel it doesn't update
> the main Makefile for the version number, so the kernel it's still 2.4.16

Marcelo forgot to update the Makefile, so if you want the appropriate
version number, just write the little changes to SUBLEVEL and EXTRAVERSION.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
