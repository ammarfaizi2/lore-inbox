Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264921AbUFLUy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbUFLUy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUFLUy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:54:59 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:54711 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S264921AbUFLUyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:54:55 -0400
Date: Sat, 12 Jun 2004 22:54:43 +0200 (CEST)
From: Koblinger Egmont <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: information leak in vga console scrollback buffer
In-Reply-To: <20040612204352.GA22347@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
 <20040612204352.GA22347@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2004, Chris Wedgwood wrote:

> > Using the standard vga console, it is easily possible to read some
> > random pieces of texts that were scrolled out a long time ago (often
>
> Feature not bug.

Rationale? (At least an rtfm-like pointer to that?)

Or are you just kidding? :-)


-- 
Egmont
