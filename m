Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135675AbRD2CTM>; Sat, 28 Apr 2001 22:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135673AbRD2CTD>; Sat, 28 Apr 2001 22:19:03 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14606 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135672AbRD2CSt>; Sat, 28 Apr 2001 22:18:49 -0400
Message-ID: <3AEB79F6.E93F8B28@transmeta.com>
Date: Sat, 28 Apr 2001 19:18:30 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Michael Rothwell <rothwell@holly-springs.nc.us>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <200104282236.AAA06021@cave.bitwizard.nl> <9cflov$fdv$1@cesium.transmeta.com> <030d01c0d05a$269c5eb0$8501a8c0@gromit>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> 
> From: "H. Peter Anvin" <hpa@zytor.com>
> > "dcim" probably stands for "digital camera images".  At least Canon
> > digital cameras always put their data in a directory named dcim.
> 
> Makes sense. FAT's root directory is limited in the number of entries it can
> contain, to something like 32. Cameras can easily produce more than that
> number of images.
> 

Usually 224.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
