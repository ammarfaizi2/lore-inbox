Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWAPPS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWAPPS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWAPPS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:18:28 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:14158 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750854AbWAPPS1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:18:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VFMu90T60jOZSy0UYZ3FNb3kjQiuDKbMnorD/GaLm/Jkqy5qCbKvE0+HyV6kmTu5fXKyw/g6/ecVBAqlrpMAmjeTUMyFxWncvlznDllQ1eVCmloOE1+aSZC4nQo07O59alJXdnmJyefkFyK5VNhmp11muzT4gD8x28J1hHyxM1A=
Message-ID: <9a8748490601160718m41365ee8pb6e4aa5b371bb8bd@mail.gmail.com>
Date: Mon, 16 Jan 2006 16:18:26 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 1/3] makes print_symbol() return int
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060116142414.GA6836@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116121611.GA539@miraclelinux.com>
	 <20060116121706.GB539@miraclelinux.com>
	 <9a8748490601160616i35fa2a6fv693d8ecc84133d5f@mail.gmail.com>
	 <20060116142414.GA6836@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Akinobu Mita <mita@miraclelinux.com> wrote:
> On Mon, Jan 16, 2006 at 03:16:36PM +0100, Jesper Juhl wrote:
> > On 1/16/06, Akinobu Mita <mita@miraclelinux.com> wrote:
> > > This patch makes print_symbol() return the number of characters printed.
> > >
> > Why?
> > Who are the users of this?
> > If there are users who can bennefit, then where's the patch to make
> > them use this new return value?
>
> Please see 2/3
>
Ahh, for some reason I have not recieved that patch via LKML, but I
found it in the archives.
Thanks.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
