Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSASWJj>; Sat, 19 Jan 2002 17:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287535AbSASWIx>; Sat, 19 Jan 2002 17:08:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28179 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287532AbSASWIL>; Sat, 19 Jan 2002 17:08:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: 19 Jan 2002 14:07:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2cqnn$2gd$1@cesium.transmeta.com>
In-Reply-To: <krienke@uni-koblenz.de> <200201182033.g0IKXE2R004723@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200201182033.g0IKXE2R004723@tigger.cs.uni-dortmund.de>
By author:    Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
In newsgroup: linux.dev.kernel
> 
> The SunOS automounter (which we used before Solaris) did this too. It was a
> pain in the neck, as the "real" path to the home does show through, and you
> get the same problems with scripts &c containing physical, not logical,
> paths to files. Fixing the _users_ is much harder than fixing up the
> configurations...
> 

However, with vfsbinds this is not an issue.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
