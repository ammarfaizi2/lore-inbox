Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSGEVFX>; Fri, 5 Jul 2002 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSGEVFX>; Fri, 5 Jul 2002 17:05:23 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:25738 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317577AbSGEVFU>; Fri, 5 Jul 2002 17:05:20 -0400
Date: Sat, 6 Jul 2002 00:07:48 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
Message-ID: <20020705210748.GO1465@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
References: <20020705184503.GQ1548@niksula.cs.hut.fi> <200207052148.QAA03113@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207052148.QAA03113@ccure.karaya.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2002 at 04:48:43PM -0500, you [Jeff Dike] wrote:
> vherva@niksula.hut.fi said:
> > ISTR UML had some security problems (guest processes being able to
> > disrupt host processes or just guest processes being able to disrupt
> > other guest processes). Have those been resolved yet?  
> 
> Can you be more specific?  That's not ringing any bells with me.

Sorry, I should've searched the archives before asking. It was just a thing
I had read somewhere, quite a while ago. Can't find the exact reference now,
but google does give a couple of hits:

http://online.securityfocus.com/bid/3973/discussion/

I just hadn't heard these having been addressed, but that's most likely just
me not following closely enough.

> As far as I know, there's nothing that needs to be resolved.

Glad to hear. I'll try it next time I'll need to jail something.


-- v --

v@iki.fi
