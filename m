Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbSLPR2H>; Mon, 16 Dec 2002 12:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbSLPR2H>; Mon, 16 Dec 2002 12:28:07 -0500
Received: from are.twiddle.net ([64.81.246.98]:3201 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266975AbSLPR2G>;
	Mon, 16 Dec 2002 12:28:06 -0500
Date: Mon, 16 Dec 2002 09:35:28 -0800
From: Richard Henderson <rth@twiddle.net>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 (minor) Alpha probs in 2.5.51
Message-ID: <20021216093528.A12560@twiddle.net>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org
References: <20021216003327.GC709@gallifrey> <20021215173827.A10954@twiddle.net> <20021216124937.GE709@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216124937.GE709@gallifrey>; from gilbertd@treblig.org on Mon, Dec 16, 2002 at 12:49:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:49:37PM +0000, Dr. David Alan Gilbert wrote:
> > Dunno.  Could be your clock chip is going bad.
> 
> Don't think so; with 2.4.19 it seems to be fine, and it returns to the
> low value after restarting a kernel from MILO even without powering the
> machine down or returning to AlphaBIOS.

On the other hand, the code hasn't changed since 2.4 either.


r~
