Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRCEKBB>; Mon, 5 Mar 2001 05:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRCEKAv>; Mon, 5 Mar 2001 05:00:51 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:27611 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129143AbRCEKAh>; Mon, 5 Mar 2001 05:00:37 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: Mon, 5 Mar 2001 11:00:17 +0100
Message-Id: <19350128033201.25316@mailhost.mipsys.com>
In-Reply-To: <19350128031945.8136@mailhost.mipsys.com>
In-Reply-To: <19350128031945.8136@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>handled correctly, does nothing more than what we need (well it does, but
>those parts,
>mostly the irq locking, got already removed), etc...

Sorry, I meant mostly the irq probing

Ben.

