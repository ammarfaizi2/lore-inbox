Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSJIP1P>; Wed, 9 Oct 2002 11:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSJIP1P>; Wed, 9 Oct 2002 11:27:15 -0400
Received: from poup.poupinou.org ([195.101.94.96]:28476 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S261839AbSJIP1O>; Wed, 9 Oct 2002 11:27:14 -0400
Date: Wed, 9 Oct 2002 17:32:57 +0200
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ducrot Bruno <poup@poupinou.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I8042_CMD_AUX_TEST oddities for some mouses.
Message-ID: <20021009153257.GB13709@poup.poupinou.org>
References: <20021008144523.GA983@poup.poupinou.org> <20021008180913.A19339@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008180913.A19339@ucw.cz>
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 06:09:13PM +0200, Vojtech Pavlik wrote:
> On Tue, Oct 08, 2002 at 04:45:23PM +0200, Ducrot Bruno wrote:
> 

[cut]

> diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	Tue Oct  8 18:08:33 2002
> +++ b/drivers/input/serio/i8042.c	Tue Oct  8 18:08:33 2002

[cut]

> + * Because it's common for chipsets to return error on perfectly functioning
> + * AUX ports, we test for this only when the LOOP command failed.
>   */

Rha..  I should read more carrefully emails before replying something stupid.

Sorry, and thank.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
