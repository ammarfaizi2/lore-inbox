Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJIJkI>; Wed, 9 Oct 2002 05:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbSJIJkI>; Wed, 9 Oct 2002 05:40:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13706 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261512AbSJIJkI>;
	Wed, 9 Oct 2002 05:40:08 -0400
Date: Wed, 9 Oct 2002 11:45:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Input - Support for PS/2 Multiplexing spec [4/23]
Message-ID: <20021009114548.A11232@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008215937.GB841@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008215937.GB841@elf.ucw.cz>; from pavel@suse.cz on Tue, Oct 08, 2002 at 11:59:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 11:59:37PM +0200, Pavel Machek wrote:

> PS/2 multiplexing spec? What is that beast? Something allowing
> notebook to work with external and internal mouse?

Exactly. It's a spec that if supported by your notebook allows the
driver to recognize which attached mouse/touchpad/touchpoint/whatever
the data is coming from and thus can talk different protocols to each of
the devices.

-- 
Vojtech Pavlik
SuSE Labs
