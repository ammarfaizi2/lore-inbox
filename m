Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbUJ0Nvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbUJ0Nvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUJ0Nve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:51:34 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:18440 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262445AbUJ0NvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:51:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Vqj8wmE4x+rYiLqItrK0bcwvpDpD3oI0XrggbuvkP1D1haqgpVXaShRvsSQnw2FCkxJqaxn3lXD1iG7UDs1WhIPW90RQLKpGizFLboJ+kNd5ZGOaevVML/r+l4d/zxiPzWW70DxWtHEguj0Kxw+ou/TtMEb96LDuEhwp0WXw1wY=
Message-ID: <58cb370e04102706512283405@mail.gmail.com>
Date: Wed, 27 Oct 2004 15:51:14 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: CaT <cat@zip.com.au>
Subject: Re: [BK PATCHES] ide-2.6 update
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041027133431.GF1127@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <20041027133431.GF1127@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2494

On Wed, 27 Oct 2004 23:34:31 +1000, CaT <cat@zip.com.au> wrote:
> On Wed, Oct 27, 2004 at 03:07:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > <bzolnier@trik.(none)> (04/10/26 1.2192)
> >    [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265
> 
> What would the symptoms of this bug be? I've got a PDC20267 and I'm
> having a few issues transferring from hde to hdh (ie across two ports)
> it seems. My work at duplicating things seems to work best when I do a
> transfer like that rather then going from say, a totall different
> controller to the pdc (hdh) or even from generated input to the pdc (hdh).
> 
> --
>     Red herrings strewn hither and yon.
