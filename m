Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285179AbRLXRIS>; Mon, 24 Dec 2001 12:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285181AbRLXRIJ>; Mon, 24 Dec 2001 12:08:09 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:34061 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S285179AbRLXRHv>; Mon, 24 Dec 2001 12:07:51 -0500
Date: Mon, 24 Dec 2001 18:08:11 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache - take two
Message-ID: <20011224170811.GA514@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg>
User-Agent: Mutt/1.3.24-current-20011218i (Linux 2.4.17 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 24 2001, Momchil Velikov wrote:

> This is the second mutation of the scalable page cache patch.
[....]

> The patch is stable on UP (survives make -j6) and does not have
> noticeable performance impact (at least for the kernel compile
> benchmark) in either direction.

Works perfectly! I'll do some further heavy testing, up to now it runs 
smooth and fine.

Happy X-Mas!  ;)

-- 
# Heinz Diehl, 68259 Mannheim, Germany
