Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSFZN5b>; Wed, 26 Jun 2002 09:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSFZN5a>; Wed, 26 Jun 2002 09:57:30 -0400
Received: from arsenal.visi.net ([206.246.194.60]:25080 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S316585AbSFZN53>;
	Wed, 26 Jun 2002 09:57:29 -0400
Date: Wed, 26 Jun 2002 09:47:15 -0400
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix .text.exit error in ieee1394/ohci1394.c
Message-ID: <20020626134715.GG496@blimpo.internal.net>
References: <Pine.NEB.4.44.0206251547300.14220-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206251547300.14220-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 03:52:58PM +0200, Adrian Bunk wrote:
> 
> The following error occured at the final linking of 2.4.19-rc1:

I thought Marcelo was already supposed to have applied this? We already
have it in our repository, and I ok'd the patch you (or someone) sent
him the last time. I don't want to resync our current repo with 2.4 this
late prior to it becoming final, so please apply this simple patch.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
