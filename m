Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUFLUn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUFLUn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUFLUn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:43:56 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:31955 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264919AbUFLUnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:43:55 -0400
Date: Sat, 12 Jun 2004 13:43:52 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Egmont Koblinger <egmont@uhulinux.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: information leak in vga console scrollback buffer
Message-ID: <20040612204352.GA22347@taniwha.stupidest.org>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 10:01:43PM +0200, Egmont Koblinger wrote:

> Using the standard vga console, it is easily possible to read some
> random pieces of texts that were scrolled out a long time ago (often
> you can see your boot messages or similar stuff even after switcing
> to another console or even to X. All you need is a local user access
> to the console.

Feature not bug.



  --cw
