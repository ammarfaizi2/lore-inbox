Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbTCTVXK>; Thu, 20 Mar 2003 16:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbTCTVXJ>; Thu, 20 Mar 2003 16:23:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5394 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262611AbTCTVXE>; Thu, 20 Mar 2003 16:23:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Release of 2.4.21
Date: 20 Mar 2003 13:33:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5dc3o$lt5$1@cesium.transmeta.com>
References: <20030320200019$6ddc@gated-at.bofh.it> <20030320203015$4839@gated-at.bofh.it> <8765qdg46i.fsf@deneb.enyo.de> <20030320210305.GH8256@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030320210305.GH8256@gtf.org>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
> 
> The ptrace bug is only one of several local root holes.  IIS would imply
> a remote vulnerability, something _far_ more serious.
> 

Don't forget: local root exploit + remote non-root exploit -> remote
root exploit.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
