Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSEaM1h>; Fri, 31 May 2002 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSEaM1g>; Fri, 31 May 2002 08:27:36 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:51316 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S315210AbSEaM1g>; Fri, 31 May 2002 08:27:36 -0400
Date: Fri, 31 May 2002 14:26:11 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Marcus Sundberg <marcus@ingate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre9-ac3
Message-ID: <20020531142611.G541@brodo.de>
In-Reply-To: <vewutkogzz.fsf@inigo.ingate.se> <20020531014935.D9282@suse.de> <21223.1022847561@www56.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 02:19:21PM +0200, Marcus Sundberg wrote:
> Dave Jones <davej@suse.de> writes:
> 
> > Two points worth mentioning in regard to this.
> > 1. The first type of speedstep (found in systems with BX chipsets)
> >    isn't supported. Only the later type found in systems with ICH
> >    chipsets will work with this driver..
> 
> What about MX chipsets? It seems to be mostly a BX without AGP,
> but it has an ICH-like AC97-controller, so...

Most probably not (yet). Please send me a /proc/pci (no need to cc:lkml), 
and then I can tell for sure.

Dominik
