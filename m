Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbUEAFIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUEAFIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUEAFIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:08:07 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:59070 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261969AbUEAFIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:08:05 -0400
Date: Fri, 30 Apr 2004 22:07:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Marc Boucher <marc@linuxant.com>
cc: "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <6900000.1083388078@[10.10.2.4]>
In-Reply-To: <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All bugs can be debugged or fixed, it's a matter of how hard it is 
> to do (generally easier with open-source) and *who* is responsible 
> for doing it (i.e. supporting the modules).

Yes, exactly. The tainted mechanism is there to tell us that it's not 
*our* problem to support it. And you deliberately screwed that up,
which is why everybody is pissed at you.

M.

