Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTKIPPf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTKIPPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:15:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58886 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262573AbTKIPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:15:33 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CRAMFS
Date: 9 Nov 2003 07:15:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bollln$uu2$1@cesium.transmeta.com>
References: <35438.128.107.165.13.1068235628.squirrel@mail.yumbrad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <35438.128.107.165.13.1068235628.squirrel@mail.yumbrad.com>
By author:    "Bradley Bozarth" <prettygood@cs.stanford.edu>
In newsgroup: linux.dev.kernel
>
> Daniel Quinlan originally maintained this, now it is orphaned.  His endian
> patch, which implemented the correct behavior according to the docs (which
> basically listed always do little endian as a todo), was dropped.
> 
> We have been maintaining this patch on our kernel, but it really should go
> in - I don't want to spend a ton of time like I did last time to have it
> dropped again, however - is anyone thinking of maintaining cramfs?  What
> are the chances of the endian fix going in if I submit it again?  (if even
> the former maintainer had no success).  I would maintain cramfs if desired
> - it hasn't really changed in a long time except in regards to higher
> level fs changes.
> 

I think Al Viro has been doing a rewrite.  You may want to check with him.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
