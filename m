Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272816AbTG3I35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272818AbTG3I35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:29:57 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:28421 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272816AbTG3I3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:29:55 -0400
Subject: Re: [PATCH] O11int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307301038.49869.kernel@kolivas.org>
References: <200307301038.49869.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1059553792.548.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Wed, 30 Jul 2003 10:29:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 02:38, Con Kolivas wrote:
> Update to the interactivity patches. Not a massive improvement but
> more smoothing of the corners.

I'm running 2.6.0-test2-mm1 + O11int.patch + O11.1int.patch and I must
say this is getting damn good! In the past, I've had to tweak scheduler
knobs to tune the engine to my taste, but since O10, this is a thing of
the past. It's working as smooth as silk...

Good work!

