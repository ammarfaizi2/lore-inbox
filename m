Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRD2AEj>; Sat, 28 Apr 2001 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135586AbRD2AEb>; Sat, 28 Apr 2001 20:04:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:13325 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132707AbRD2AEP>; Sat, 28 Apr 2001 20:04:15 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Sony Memory stick format funnies...
Date: 28 Apr 2001 17:03:43 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9cflov$fdv$1@cesium.transmeta.com>
In-Reply-To: <200104282236.AAA06021@cave.bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200104282236.AAA06021@cave.bitwizard.nl>
By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
In newsgroup: linux.dev.kernel
> 
> # l /mnt/d1
> total 16
> drwxr-xr-x 512 root     root        16384 Mar 24 17:26 dcim/
> -r-xr-xr-x   1 root     root            0 May 23  2000 memstick.ind*
> # 
> 
> Where the *(&#$%& does that "dcim" directory come from????
> 

"dcim" probably stands for "digital camera images".  At least Canon
digital cameras always put their data in a directory named dcim.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
