Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSGAQFP>; Mon, 1 Jul 2002 12:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSGAQFO>; Mon, 1 Jul 2002 12:05:14 -0400
Received: from erasmus.off.net ([64.39.30.25]:28430 "EHLO erasmus.off.net")
	by vger.kernel.org with ESMTP id <S315721AbSGAQFM>;
	Mon, 1 Jul 2002 12:05:12 -0400
Date: Mon, 1 Jul 2002 12:07:40 -0400
From: Zach Brown <zab@zabbo.net>
To: Samuel Thibault <samuel.thibault@fnac.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 linux/drivers/maestro.c dev_audio flaw
Message-ID: <20020701120740.J28390@erasmus.off.net>
References: <Pine.LNX.4.44.0206302335280.592-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206302335280.592-100000@localhost.localdomain>; from Samuel.Thibault@ens-lyon.fr on Sun, Jun 30, 2002 at 11:49:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems that the value of ess->dev_audio is wrongly interpreted. 

Thanks for attacking this driver, Samuel.  Your patches have looked good
so far.  I'm sorry I'm not more involved; its been quite a while since
I've futzed about with the maestro(s).

You may want to cc: your fixes to Takashi Iwai <tiwai@suse.de> , who
actively maintains the ALSA equivalent drivers.  He'll have a much
greater chance of affecting change than I do :)

- z
