Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSEBUrF>; Thu, 2 May 2002 16:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSEBUrE>; Thu, 2 May 2002 16:47:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35846 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315416AbSEBUrB>; Thu, 2 May 2002 16:47:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, bzElf support 11/11
Date: 2 May 2002 13:45:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aas8i5$qsa$1@cesium.transmeta.com>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org> <m11ycuy48d.fsf_-_@frodo.biederman.org> <m1wuumwpkk.fsf_-_@frodo.biederman.org> <m1sn5awpg2.fsf_-_@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1sn5awpg2.fsf_-_@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
>
> Please apply,
> 
> This patch allows a bzELF image to be built instead of a bzImage.
> A bzELF is just a bzImage represented in the ELF file format.  The transform
> from bzELF to bzImage is 1-1.
> 

... thus adding another binary format for no gain.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
