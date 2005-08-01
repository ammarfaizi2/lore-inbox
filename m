Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVHASyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVHASyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVHASyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:54:41 -0400
Received: from graphe.net ([209.204.138.32]:22734 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261164AbVHASyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:54:40 -0400
Date: Mon, 1 Aug 2005 11:54:37 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <Pine.LNX.4.62.0508011147030.5541@graphe.net>
Message-ID: <Pine.LNX.4.62.0508011153200.5664@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The full patchset that also includes the modifications to 
/proc/<pid>/ smaps to support outputting numa information can be found at

ftp://ftp.kernel.org/pub/linux/kernel/people/christoph/numa/2.6.13-rc4-mm1.
