Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVCPF1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVCPF1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVCPF1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:27:17 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:46348
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262523AbVCPF1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:27:12 -0500
Date: Tue, 15 Mar 2005 21:27:11 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace zone padding with a definition in cache.h
In-Reply-To: <20050315212337.5484f2a0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503152126380.6196@server.graphe.net>
References: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
 <20050315202331.008ec856.akpm@osdl.org> <Pine.LNX.4.58.0503152103580.6087@server.graphe.net>
 <20050315212337.5484f2a0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Andrew Morton wrote:

> > If the struct is named then there may be
> > conflicts if its used repeatedly.
>
> Hence the "hack" which you just deleted ;)

Ok, Master, I see the light....
