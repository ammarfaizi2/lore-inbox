Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbSLDTxg>; Wed, 4 Dec 2002 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSLDTxg>; Wed, 4 Dec 2002 14:53:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267050AbSLDTxf>; Wed, 4 Dec 2002 14:53:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
Date: 4 Dec 2002 12:00:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aslmtl$im$1@cesium.transmeta.com>
References: <9633612287A@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9633612287A@vcnet.vc.cvut.cz>
By author:    "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
In newsgroup: linux.dev.kernel
> 
> And because of I was not able to find anything in POSIX which would say
> that we should do split on spaces (not that I found that we should not), 
> I vote for leaving current behavior in Linux, and fixing perl manpage 
> (and eventually FreeBSD, if anyone is interested) instead.
> 

Classic catch-22: POSIX won't standardize it because of lack of
consistency between UNIX implementations, although everyone pretty
much agrees it would be a desirable feature to add to the standard.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
