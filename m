Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSLMOfU>; Fri, 13 Dec 2002 09:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLMOfU>; Fri, 13 Dec 2002 09:35:20 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:14743 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264690AbSLMOfT>;
	Fri, 13 Dec 2002 09:35:19 -0500
Date: Fri, 13 Dec 2002 15:43:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: key "stuck" after resume
Message-ID: <20021213154302.B6001@ucw.cz>
References: <20021212194644.GA767@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021212194644.GA767@elf.ucw.cz>; from pavel@ucw.cz on Thu, Dec 12, 2002 at 08:46:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 08:46:44PM +0100, Pavel Machek wrote:

> Hi!
> 
> Vojtech, would it be possible to clear "keyboard down" map during
> resume? It is pretty unlikely to be valid at that point :-).
> 								Pavel

Yes, that is possible (and not that hard to do).

-- 
Vojtech Pavlik
SuSE Labs
