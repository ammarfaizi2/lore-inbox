Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUL2OtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUL2OtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbUL2OtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:49:07 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:61317 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261335AbUL2OtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:49:03 -0500
Date: Wed, 29 Dec 2004 15:48:53 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
Message-ID: <20041229144853.GA5435@wohnheim.fh-wedel.de>
References: <juhl-lkml@dif.dk> <Pine.LNX.4.61.0412290347020.28589@dragon.hygekrogen.localhost> <200412291342.iBTDgeKe007858@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200412291342.iBTDgeKe007858@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 December 2004 10:42:40 -0300, Horst von Brand wrote:
> Jesper Juhl <juhl-lkml@dif.dk> said:
> > On Wed, 29 Dec 2004, Jörn Engel wrote:
> > > On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> > > > -		if(file->private_data != NULL) {
> > > > +		if (file->private_data != NULL) {
> > > 
> > > 		if (file->private_data) {
> > > 
> > > It's a question of taste, but in most cases I consider the shorter
> > > version to be more obvious.
> > > 
> > Yeah, matter of personal preference, but since both styles are used in the 
> > file I had to pick one of them to try and make it consistent - I simply 
> > picked my personally prefered form.
> 
> Nope. See Documentation/CodingStyle (it implicitly agrees with you, BTW).

Can you be more specific?  Did you mean the "if (x is true) {" part?

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
