Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbTCaU75>; Mon, 31 Mar 2003 15:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbTCaU75>; Mon, 31 Mar 2003 15:59:57 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:13525 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261848AbTCaU74>;
	Mon, 31 Mar 2003 15:59:56 -0500
Date: Mon, 31 Mar 2003 23:11:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Autorepeat problems in 2.5.66
Message-ID: <20030331231110.A27978@ucw.cz>
References: <20030331191128.GA204@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030331191128.GA204@elf.ucw.cz>; from pavel@ucw.cz on Mon, Mar 31, 2003 at 09:11:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 09:11:28PM +0200, Pavel Machek wrote:

> I have strange autorepeat problems in 2.5.66: it sometimes repeats a
> key (on console) when it should not do that. Perhaps vesafb blocks
> interrupts for too long and software autorepeat screws it up?

Might be.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
