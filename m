Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290757AbSAYR4s>; Fri, 25 Jan 2002 12:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290758AbSAYR4i>; Fri, 25 Jan 2002 12:56:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58638 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290757AbSAYR4V>; Fri, 25 Jan 2002 12:56:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: restoring hard linked files from zisofs/iso9660 w. RR
Date: 25 Jan 2002 09:55:57 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2s67d$8s0$1@cesium.transmeta.com>
In-Reply-To: <20020125135545.A28897@espoo.tasking.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020125135545.A28897@espoo.tasking.nl>
By author:    Frank van Maarseveen <fvm@altium.nl>
In newsgroup: linux.dev.kernel
>
> This doesn't seem to work due to inode number differences. Is
> this a fundamental problem or can it be solved somehow, e.g.
> by an attribute which refers to a sort of "original" inode
> number?
> 

WHAT doesn't work?

> or by a more advanced inode number synthesis in fs/isofs?

There is, I belive, an inode number RR attribute.  Last I checked I
was happily using hard links with RockRidge...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
