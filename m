Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262551AbSJBTai>; Wed, 2 Oct 2002 15:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbSJBTai>; Wed, 2 Oct 2002 15:30:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32263 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262551AbSJBTah>;
	Wed, 2 Oct 2002 15:30:37 -0400
Date: Wed, 2 Oct 2002 21:36:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a problem report
Message-ID: <20021002213600.A2017@mars.ravnborg.org>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	linux-kernel@vger.kernel.org
References: <20021002184911.GG1536@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021002184911.GG1536@cadcamlab.org>; from peter@cadcamlab.org on Wed, Oct 02, 2002 at 01:49:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 01:49:11PM -0500, Peter Samuelson wrote:
> [Sam Ravnborg]
[Snip faulty Config.in patch]

> That's not right.  You can't use '||' in config language.  (Try it
> with xconfig some time.)

I was aware of this, the only reason why I posted this was to let people
proceed with menuconfig, and to give them a response.

Roman Zippel already posted a correct path, that he also has sent to Linus.
Although I do not understand where the ALSA people are in this game.

> This 'if' statement syntax has *got* to go.  I posted an incomplete
> replacement syntax some time ago, but abandoned it because it appeared
> Roman was almost ready to merge his new config stuff....
The 2.5.39 version of Roman's lkc looked really good IMHO, but I think
more people has to get into the discussion before it will be accepted.
I for one is not the right person to comment on the config
language, old or new.

	Sam

