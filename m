Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272484AbTHEHX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTHEHX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:23:56 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37636 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272484AbTHEHXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:23:55 -0400
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Martin Konold <martin.konold@erfrakon.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308050704.22684.martin.konold@erfrakon.de>
References: <200308050704.22684.martin.konold@erfrakon.de>
Content-Type: text/plain
Message-Id: <1060068224.604.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 05 Aug 2003 09:23:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 07:04, Martin Konold wrote:
> Hi,
> 
> when using  2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM) I notice 
> very significant slowdown in interactive usage compared to 2.4.21.

Please, upgrade to the latest 2.6.0-test kernel, as there are a lot of
people working on the CPU scheduler and interactivity. As of this mail,
it's 2.6.0-test2-bk4. If you prefer, you can also test 2.6.0-test2-mm4
(Andrew Morton patches on top of 2.6.0-test2).

This way, you can help us in improving the interactive feeling of future
2.6 kernels.

