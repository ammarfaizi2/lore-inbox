Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUFLU7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUFLU7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUFLU7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:59:08 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:59114 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264920AbUFLU7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:59:06 -0400
Date: Sat, 12 Jun 2004 13:59:03 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Koblinger Egmont <egmont@uhulinux.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: information leak in vga console scrollback buffer
Message-ID: <20040612205903.GA22428@taniwha.stupidest.org>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu> <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 10:54:43PM +0200, Koblinger Egmont wrote:

> Rationale? (At least an rtfm-like pointer to that?)

Maybe I didn't full understand you.  Generally I find it desirable to
be able to read things that scrolled off the screen a long time ago.
It's very useful for unattended machines if I need to 'look' back.

I take it you're talking about something beyond that?


   --cw
