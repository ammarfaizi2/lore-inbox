Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275262AbTHSAhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275266AbTHSAhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:37:50 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:32269 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S275262AbTHSAhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:37:47 -0400
Date: Tue, 19 Aug 2003 10:37:19 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Valdis.Kletnieks@vt.edu
cc: Phil Oester <kernel@theoesters.com>, <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>
Subject: Re: [PATCH] Ratelimit SO_BSDCOMPAT warnings 
In-Reply-To: <200308182215.h7IMFecc013449@turing-police.cc.vt.edu>
Message-ID: <Mutt.LNX.4.44.0308191036110.8095-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 Valdis.Kletnieks@vt.edu wrote:

> If so, why are we bothering at all?  Once *per process* I could see, but
> once per boot?

Once per process is too complicated, and an aggregate of people reporting 
the message should lead to all of the major apps being fixed.


- James
-- 
James Morris
<jmorris@intercode.com.au>

