Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSLPXIo>; Mon, 16 Dec 2002 18:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSLPXIn>; Mon, 16 Dec 2002 18:08:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262040AbSLPXIl>; Mon, 16 Dec 2002 18:08:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to do -nostdinc?
Date: 16 Dec 2002 15:16:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <atlms2$sb4$1@cesium.transmeta.com>
References: <20021216182919.GA1607@mars.ravnborg.org> <20218.1040073993@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20218.1040073993@ocs3.intra.ocs.com.au>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
> 
> Does gcc still mark -iwithprefix as deprecated?  If it does then do not
> rely on it and use (1a).  If gcc will support -iwithprefix then use (2).
> 

If they do, let's apply a cluebat and explain to them that there is no
acceptable substitute for many nonhosted applications, not just the
Linux kernel.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
