Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTDDWxd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbTDDWxd (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:53:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261440AbTDDWxc (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 17:53:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VGER's filters..
Date: 4 Apr 2003 15:04:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6l32k$3f4$1@cesium.transmeta.com>
References: <20030404181054.GT29167@mea-ext.zmailer.org> <b6kqc4$2td$1@cesium.transmeta.com> <20030404210530.GV29167@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030404210530.GV29167@mea-ext.zmailer.org>
By author:    Matti Aarnio <matti.aarnio@zmailer.org>
In newsgroup: linux.dev.kernel
> 
> > I suspect in Sendmail it naturally falls out of using a single set
> > of canonicalization rules for all syntax.
> 
> Nope, the protocol line parser in original version was simple,
> it reused same code for "MAIL FROM:" and "RCPT TO:" as for
> "From:" and "To:",...
> 

It's that what I said?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
