Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbRBMAd2>; Mon, 12 Feb 2001 19:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRBMAdT>; Mon, 12 Feb 2001 19:33:19 -0500
Received: from mpoli.fi ([62.236.132.1]:43537 "EHLO mpoli.fi")
	by vger.kernel.org with ESMTP id <S130000AbRBMAdE>;
	Mon, 12 Feb 2001 19:33:04 -0500
Date: Tue, 13 Feb 2001 02:28:06 +0200
From: Olli Lounela <olli@mpoli.fi>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fwd: Mylex dac960 not SMP-safe?
Message-ID: <20010213022806.A31582@mpoli.fi>
Reply-To: olli@mpoli.fi
In-Reply-To: <20010212134757.A18423@mpoli.fi> <200102121702.f1CH20U03841@dandelion.com> <20010213015501.J17002@mpoli.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010213015501.J17002@mpoli.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 01:55:01AM +0200, Olli Lounela wrote:
> 
> Finally got 2.4.2pre3 nosmp boot dmesg, attached. Also current lspci -vvvxx

Okay, I goofed. The motherboard reset the interrupts to the same old stoopid
values when I shuffled the cards. I have now separated them, no difference.
-- 
    Olli               ...and he thought I'm serious! Hahahaha...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
