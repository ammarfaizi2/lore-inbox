Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSKRNxG>; Mon, 18 Nov 2002 08:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSKRNxG>; Mon, 18 Nov 2002 08:53:06 -0500
Received: from zero.aec.at ([193.170.194.10]:15109 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262646AbSKRNxG>;
	Mon, 18 Nov 2002 08:53:06 -0500
Date: Mon, 18 Nov 2002 14:58:44 +0100
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix compile breakage in fs/ after nanosecond stat timefields patch
Message-ID: <20021118135844.GA2406@averell>
References: <20021118112108.GA5420@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118112108.GA5420@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 12:21:09PM +0100, Adrian Bunk wrote:
> Hi Andi,
> 
> the patch below fixes the following compile errors in 2.5.48:

Seems correct.

Weird, I could swear I (compile) tested all these.

-Andi
