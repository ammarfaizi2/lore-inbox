Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUFMLtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUFMLtL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 07:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUFMLtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 07:49:11 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:24980 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S265048AbUFMLtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 07:49:10 -0400
Date: Sun, 13 Jun 2004 13:48:57 +0200 (CEST)
From: Koblinger Egmont <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: information leak in vga console scrollback buffer
In-Reply-To: <40CC31E6.8080201@ThinRope.net>
Message-ID: <Pine.LNX.4.58L0.0406131347550.3126@sziami.cs.bme.hu>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
 <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
 <20040612205903.GA22428@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122301250.25004@sziami.cs.bme.hu>
 <40CBC094.6050901@ThinRope.net> <Pine.LNX.4.58L0.0406131023260.18435@sziami.cs.bme.hu>
 <40CC31E6.8080201@ThinRope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2004, Kalin KOZHUHAROV wrote:

> What happens:
> I saw a bunch of garbage plus pieces of text (/etc/shadow form previous
> tests and so on), this is a security flaw, NOT feature.

Well, this is what I was talking about :-)))

There's only one question left: who's willing and able to fix it?


-- 
Egmont
