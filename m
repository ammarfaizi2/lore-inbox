Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWBTXp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWBTXp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBTXp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:45:59 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:11398 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964853AbWBTXp6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:45:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jpBbo+pc3xDJAyXElRh5l6Q03J99Hxodn3yhD5CT0wrF/OqabqvUswn9RLWYpbuRt4fQ7m2zKDOn6/uI8wAS7uk3Ce2OgOcq41OL5iuqBUngS6o8XjYC7RE7npu45jEwEqyLvtnnAzL2hcBigjnQqZEI5TIOVkXh/c0eMoQOayk=
Message-ID: <6bffcb0e0602201545p69c0e20aq@mail.gmail.com>
Date: Tue, 21 Feb 2006 00:45:57 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: [PATCH] mm: Implement swap prefetching
Cc: "Mattia Dongili" <malattia@linux.it>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "ck list" <ck@vds.kolivas.org>
In-Reply-To: <200602210758.01283.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602210044.52424.kernel@kolivas.org>
	 <20060220190855.GB4414@inferi.kami.home>
	 <200602210758.01283.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/06, Con Kolivas <kernel@kolivas.org> wrote:
> On Tuesday 21 February 2006 06:08, Mattia Dongili wrote:
> > TestSetPageLRU is gone in -mm (see mm-pagelru-no-testset.patch), you
> > should probably change it to
>
> Here's a respin with that change.
>
> Cheers,
> Con

Thanks!

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
