Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281547AbRKUAuy>; Tue, 20 Nov 2001 19:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281552AbRKUAuo>; Tue, 20 Nov 2001 19:50:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34826 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281547AbRKUAuc>; Tue, 20 Nov 2001 19:50:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: swsusp for 2.4.14
Date: 20 Nov 2001 16:50:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9teto3$65c$1@cesium.transmeta.com>
In-Reply-To: <20011121001858.B183@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011121001858.B183@elf.ucw.cz>
By author:    Pavel Machek <pavel@suse.cz>
In newsgroup: linux.dev.kernel
> 
> Warning. This probably corrupts memory. (All previous versinos did,
> just noone noticed becuase it needed 20+ suspend/resume cycles). This
> is probably best version ever, but it still corrupts data.
> 

This is all very cool.  May I suggest to use the term "hibernate"
though, since "suspend" by itself usually refers to suspend to RAM
(S3) as opposed to suspend to disk (S4).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
