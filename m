Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132325AbQK0E4J>; Sun, 26 Nov 2000 23:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132476AbQK0Ez7>; Sun, 26 Nov 2000 23:55:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18692 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S132325AbQK0Ezl>; Sun, 26 Nov 2000 23:55:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Universal debug macros.
Date: 26 Nov 2000 20:25:38 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vsno2$pc6$1@cesium.transmeta.com>
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl> <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
By author:    Elmer Joandi <elmer@ylenurme.ee>
In newsgroup: linux.dev.kernel
> 
> Red Hat will ship two kernels. Well, they actually ship now about 4 ones
> or something. So they will ship 8.
> 

Something RedHat & co may want to consider doing is providing a basic
kernel and have, as part of the install procedure or later, an
automatic recompile and install kernel procedure.  It could be
automated very easily, and on all but the very slowest of machines, it
really doesn't take that long.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
