Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbSLUMAD>; Sat, 21 Dec 2002 07:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSLUMAD>; Sat, 21 Dec 2002 07:00:03 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:1972 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266903AbSLUMAC> convert rfc822-to-8bit; Sat, 21 Dec 2002 07:00:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - interactive_delta
Date: Sat, 21 Dec 2002 13:07:15 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>
References: <200212211539.56815.conman@kolivas.net>
In-Reply-To: <200212211539.56815.conman@kolivas.net>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212211307.15666.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 December 2002 05:39, Con Kolivas wrote:

Hi Con,

> Seems like io_load likes lower interactive deltas (lower the better?) and
> mem_load likes high interactive_deltas (sweet spot 5).
Yes, seems so. I think this is a good thing for autoregulating 8-)

ciao, Marc
