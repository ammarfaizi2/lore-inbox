Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUBJUN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUBJUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:11:57 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1408 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265632AbUBJULs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:11:48 -0500
Date: Tue, 10 Feb 2004 21:11:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard in 2.6 and 2.4 (newbe)
Message-ID: <20040210201146.GC261@ucw.cz>
References: <Sea2-F7FJ2I13pL32ct00010d7f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F7FJ2I13pL32ct00010d7f@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:43:48PM +0200, sting sting wrote:
> Hello,
> I see that under /drivers/input in 2.6 there is no
> keybdev.c (in 2.4 there was)
> and therefore there is no keybdev.ko.
> There is still mousedev.c in 2.6 under /drivers/input
> What does replace keybdev.o of 2.4 ?

drivers/char/keyboard.c

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
