Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTEBSVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTEBSVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:21:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263078AbTEBSUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:20:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Date: 2 May 2003 11:32:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8udjm$cgq$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com> <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk>
By author:    John Bradford <john@grabjohn.com>
In newsgroup: linux.dev.kernel
> 
> Slightly off-topic, but does anybody know whether IA64 or x86-64 allow
> you to make the stack non-executable in the same way you can on SPARC?
> 

x86-64 definitely does, and it's the default on Linux/x86-64.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
