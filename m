Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVA3W0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVA3W0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVA3W0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:26:13 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:13378 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261810AbVA3W0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:26:08 -0500
Date: Sun, 30 Jan 2005 23:27:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/kallsyms.c: make some code static
Message-ID: <20050130222753.GC14816@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050121100747.GC3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121100747.GC3209@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 11:07:47AM +0100, Adrian Bunk wrote:
> This patch makes some needlessly global code static.

Applied,

	Sam
