Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVGOCAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVGOCAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbVGOCAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:00:17 -0400
Received: from graphe.net ([209.204.138.32]:16601 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263125AbVGOCAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:00:15 -0400
Date: Thu, 14 Jul 2005 19:00:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: David Gibson <david@gibson.dropbear.id.au>
cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Hugepage COW
In-Reply-To: <20050715011428.GC7750@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0507141858220.21873@graphe.net>
References: <20050707055554.GC11246@localhost.localdomain>
 <Pine.LNX.4.62.0507141022440.14347@graphe.net> <20050715011428.GC7750@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, David Gibson wrote:

> Well, the COW patch implements a fault handler, obviously.  What
> specifically where you thinking about?

About a fault handler of course and about surrounding scalability issues.
I worked on some hugepage related patches last fall. Have you had a look 
at the work of Ken, Ray and me on the subject?


