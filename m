Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbTJJTMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTJJTMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:12:25 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:10181 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S262753AbTJJTMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:12:24 -0400
Date: Fri, 10 Oct 2003 21:12:16 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atyfb updates
In-Reply-To: <Pine.GSO.4.21.0310101754050.8302-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0310102109560.7665-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Oct 2003, Geert Uytterhoeven wrote:

> This one is still needed to get atyfb compiled when Mach64 GX support is
> enabled.

Ok, go ahead! We'll also need to get that Mach64 LT fifo width set to 24
bit and the Powerbook special detection applied.

Daniël

