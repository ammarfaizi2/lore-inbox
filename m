Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSKDCiX>; Sun, 3 Nov 2002 21:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSKDCiX>; Sun, 3 Nov 2002 21:38:23 -0500
Received: from holomorphy.com ([66.224.33.161]:55441 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264629AbSKDCiW>;
	Sun, 3 Nov 2002 21:38:22 -0500
Date: Sun, 3 Nov 2002 18:43:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/bug.h and asm/bug.h
Message-ID: <20021104024305.GT23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021104022350.DB97A2C0C0@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104022350.DB97A2C0C0@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:22:45PM +1100, Rusty Russell wrote:
> As the number of bug-related macros grows, this makes sense.
> 1) Introduce linux/bug.h and #include it from linux/kernel.h so noone
>    breaks.
> 2) Move BUG() macro from asm*/page.h to asm*/bug.h, and #include it.
> Thanks,
> Rusty.

Thank you, this is a longstanding source of irritation (from the
standpoint of mere cleanliness) here.


Bill
