Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRHFRDi>; Mon, 6 Aug 2001 13:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbRHFRD2>; Mon, 6 Aug 2001 13:03:28 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17024
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268897AbRHFRDS>; Mon, 6 Aug 2001 13:03:18 -0400
Date: Mon, 6 Aug 2001 10:03:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip driver problem
Message-ID: <20010806100319.C833@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <200108061619.f76GJAA99461@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108061619.f76GJAA99461@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 12:19:10PM -0400, Albert D. Cahalan wrote:

> This is the Force PowerCore 6750 single-board computer with
> a PowerPC processor and the DEC 21143 Ethernet chip.

Just wondering, but when booting 2.4.x, do you see something like:
"Unknown bridge resource %d: assuming transparent"
for the tulip?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
