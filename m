Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272828AbTG3Imz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272831AbTG3Imz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:42:55 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:30213 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272828AbTG3Ils (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:41:48 -0400
Subject: Re: [PATCH] O11int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307301038.49869.kernel@kolivas.org>
References: <200307301038.49869.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1059554506.569.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Wed, 30 Jul 2003 10:41:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 02:38, Con Kolivas wrote:
> Update to the interactivity patches. Not a massive improvement but
> more smoothing of the corners.

Wops! Wait a minute! O11.1 is great, but I've had a few XMMS skips that
I didn't have with O10. They're really difficult to reproduce, but I've
seen them when moving a window slowly enough to make the underlying
windows accumulate a lot of redrawing events. Also, although O11.1 feels
smooth, it's not as smooth as O10 is for me. 

All in all, O11.1 is damn good, but O10 is the greatest scheduler I've
seen to date.

