Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTLSQaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTLSQaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:30:18 -0500
Received: from main.gmane.org ([80.91.224.249]:55196 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263460AbTLSQaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:30:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: nick black <dank@suburbanjihad.net>
Subject: Re: 2.6-test11 framebuffer Matrox
Date: Fri, 19 Dec 2003 16:29:22 +0000 (UTC)
Message-ID: <brv911$but$2@sea.gmane.org>
References: <200312190314.13138.schwientek@web.de> <3FE2BB05.1000107@convergence.de>
Reply-To: dank@reflexsecurity.com
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FE2BB05.1000107@convergence.de>, Michael Hunold wrote:
> Hmm, I just tested with the 2.6.0 release and my both cards are working 
> properly now. The only thing is a huge white box around the penguin logo.

As I said, this happens to me without Petr's patch, and goes away with
it.  Can you check out my earlier post in this thread, and analyze your
X+fbcon interaction with reagrds to fbdev vs. mga driver, and Petr's
patch?

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

