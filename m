Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbUKNP4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUKNP4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 10:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUKNP4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 10:56:34 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:37458 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261313AbUKNPwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 10:52:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=r1bhNEaJziiyIyl1fmAa0PUI6IcWDcne+xCnL5Y0zvdoA7sUJ4YomIwcRqThe/RMNWbPyz1wNymWgNumwLLSSkun7z0ofn301YGGV12YrBiSyUXL2avYjQ4ndHS1wCnMZQN/nqv3zUITNcXe9VxUU2pMG68oKEu5twXSrb0x1wc=
Message-ID: <bd8e30a404111407527403c134@mail.gmail.com>
Date: Sun, 14 Nov 2004 07:52:16 -0800
From: "Paul G. Allen" <pgallen@gmail.com>
Reply-To: "Paul G. Allen" <pgallen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling RHEL WS Kernels
In-Reply-To: <200411141210.iAECAIgd011479@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411141210.iAECAIgd011479@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stupid, stupid, stupid....

....I forgot mrproper. I'm so used to not having to use it that I
forgot. /me feels like an idiot. That said, the stock kernel should
have recognized my USB devices, LCD resolution, and touchpad like RH
9.0 did without having to re-compile (but that's RH's problem, not
this list).

I still have some warnings when it boots about missing modules
(char_major_xxx), but I'm sure I can fix that.

Now my only issue is why Doom 3 runs at a snail's pace now, but then
running games isn't that important in the larger scheme of things.

PGA
