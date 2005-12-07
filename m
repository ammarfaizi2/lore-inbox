Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVLGQ3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVLGQ3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLGQ3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:29:24 -0500
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:18876 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S1751182AbVLGQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:29:23 -0500
From: Massimiliano Hofer <max@bbs.cc.uniud.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Wed, 7 Dec 2005 17:29:18 +0100
User-Agent: KMail/1.9
References: <200512071605.jB7G5M84007973@laptop11.inf.utfsm.cl>
In-Reply-To: <200512071605.jB7G5M84007973@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071729.18797.max@bbs.cc.uniud.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 7 December 2005 5:05 pm, Horst von Brand wrote:

> You can certainly keep 2.6.x.y for a while when 2.6.(x+1) shows up, and
> even wait for 2.6.(x+1).1. Note that the stable series maintainers are
> sypmathetic to the idea of doing a last 2.6.x.(y+1), flushing the queued
> patches when 2.6.(x+1) shows up. Is this enough for you?

If a 2.6.x.1 is released and a vulnerability is discovered with the wrong 
timing, this leaves us with a kernel that has had little or no testing.

We already had a 2.6.x that didn't even boot on half my servers. When 2.6.x.1 
is the first bootable version and a security patch arrives, this leaves me 
with an uncomfortable choice between an old, stable and vulnerable version 
and a new, shiny and untested one.

Having 2.6.x-1.y and 2.6.x.y would avoid this situation.

-- 
Bye,
   Massimiliano Hofer
