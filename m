Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289277AbSAVWTm>; Tue, 22 Jan 2002 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288121AbSAVWTg>; Tue, 22 Jan 2002 17:19:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28947 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289490AbSAVWTQ>; Tue, 22 Jan 2002 17:19:16 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.18-pre5
Date: 22 Jan 2002 14:18:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2kogi$mpt$1@cesium.transmeta.com>
In-Reply-To: <200201221849.g0MInD012825@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200201221849.g0MInD012825@vindaloo.ras.ucalgary.ca>
By author:    Richard Gooch <rgooch@ras.ucalgary.ca>
In newsgroup: linux.dev.kernel
>
>   Hi, Marcelo. patch-2.4.18-pre5.gz is in fact an incremental diff
> between 2.4.18-pre4 -> 2.4.18-pre5, rather than a diff against 2.4.17.
> This in turn appears to have broken the script that puts incremental
> diffs into testing/incr.
> 

Indeed it did... I think I've cleaned up the resulting mess now.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
