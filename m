Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271833AbTGRPGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271837AbTGRPEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:04:31 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:8362
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S268238AbTGROee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:34:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Valdis.Kletnieks@vt.edu, Danek Duvall <duvall@emufarm.org>
Subject: Re: [PATCH] O6.1int
Date: Sat, 19 Jul 2003 00:52:37 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307171635.25730.kernel@kolivas.org> <20030718070749.GA12466@lorien.emufarm.org> <200307181443.h6IEhnq3002916@turing-police.cc.vt.edu>
In-Reply-To: <200307181443.h6IEhnq3002916@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307190052.38021.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003 00:43, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 18 Jul 2003 00:07:49 PDT, Danek Duvall said:
> > I did discover under O6.1int that I could make xmms block indefinitely
> > when opening a window, with fvwm's wire frame manual placement, which I
> > hadn't ever noticed before, but I'm not sure if that's because it
> > actually wasn't there before, or I just placed the windows more quickly.
>
> This could be a result of fvwm grabbing the X server while the wireframe
> stuff is going on, and xmms being blocked trying to update the image on
> screen (think "scrolling song title" ;)

I'm pretty sure if you were really unlucky you could hit just the wrong timing 
with O6.1 which might do this. O7 I believe addresses this.

Con

