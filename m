Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTKEMar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 07:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTKEMaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 07:30:46 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:19933 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262882AbTKEMap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 07:30:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm2
References: <20031104225544.0773904f.akpm@osdl.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 05 Nov 2003 13:30:15 +0100
In-Reply-To: <20031104225544.0773904f.akpm@osdl.org>
Message-ID: <87ptg7ov54.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> [SNIP]
>

FWIW, it compiles nicely, runs nicely and as with -mm1, I haven't
really found problems I can't blame myself for (seems to go bonk from
time to time with vmware modules, likewise with the orinoco-usb
driver, but without those it is very nice :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
