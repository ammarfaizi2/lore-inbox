Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSJNQgi>; Mon, 14 Oct 2002 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJNQfw>; Mon, 14 Oct 2002 12:35:52 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:47115 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S261996AbSJNQft>;
	Mon, 14 Oct 2002 12:35:49 -0400
Date: Mon, 14 Oct 2002 18:40:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Matt_Domsch@Dell.com
Cc: rob@osinvestor.com, davej@codemonkey.org.uk, rddunlap@osdl.org,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021014184031.A19866@medelec.uia.ac.be>
References: <20BF5713E14D5B48AA289F72BD372D68C1E9A1@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E9A1@AUSXMPC122.aus.amer.dell.com>; from Matt_Domsch@Dell.com on Mon, Oct 14, 2002 at 10:51:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

> > Also, I've got patches around from Matt Domsch that did the 
> > move, and changed
> > around the necessary drivers/char/ files.  I haven't been 
> > keeping them up-to- date, maybe Matt has.
> 
> I haven't been, but it doesn't look too painful to do it.  The Natsemi
> SCx200 merge is what's screwing up BK's automerge of it (I hadn't updated
> that tree since April...).
> 
> The move work took me a few hours last time I did it, I can resurrect that
> now that there's interest.  Give me a few hours, today's kind of busy...

I just did it myself this afternoon. It's indeed not to painfull to do this.
I'll prepare some first patches tonight, so that people can start playing 
with it. Second patch will be to make sure that it's all C99 designated 
initializers.

Greetings,
Wim.

