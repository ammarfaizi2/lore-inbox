Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTH0Fv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 01:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTH0Fv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 01:51:26 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:4335 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S263114AbTH0FvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 01:51:22 -0400
From: Matt Gibson <gothick@codewave.demon.co.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.23-pre1] /proc/ikconfig support
Date: Wed, 27 Aug 2003 00:06:47 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva> <20030826223328.GC27422@merlin.emma.line.org>
In-Reply-To: <20030826223328.GC27422@merlin.emma.line.org>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308270006.47645.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 Aug 2003 23:33, Matthias Andree wrote:
>
> Precedent: admin at a site changes, original .config was snatched from
> some other machine, and kernel sources have been removed from $NOTEBOOK
> because space was tight... In such cases, a config store is pretty
> handy. Extract, make oldconfig, there you go.

Or, as happened with me on SuSE kernels (which had/have a similar arrangement 
patched in) -- your distro ships with a precompiled kernel, you download a 
new one from kernel.org, and you can configure it very quickly to match what 
you've already got.  Far quicker than starting from scratch.

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
