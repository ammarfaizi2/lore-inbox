Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVGGRPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVGGRPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVGGRPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:15:40 -0400
Received: from graphe.net ([209.204.138.32]:31707 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261407AbVGGRPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:15:25 -0400
Date: Thu, 7 Jul 2005 10:15:19 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <20050707163604.GJ21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507071014430.6511@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <20050707162442.GI21330@wotan.suse.de> <Pine.LNX.4.62.0507070930220.5875@graphe.net>
 <20050707163604.GJ21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Andi Kleen wrote:

> > node = -1 if the node cannot be determined.
> 
> But that will crash right now.

That was fixed. Have a look at the git logs.

