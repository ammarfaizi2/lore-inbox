Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268712AbTBZQTc>; Wed, 26 Feb 2003 11:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268784AbTBZQTc>; Wed, 26 Feb 2003 11:19:32 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:47303 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S268712AbTBZQTb>; Wed, 26 Feb 2003 11:19:31 -0500
Date: Wed, 26 Feb 2003 16:29:44 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Tighten up serverworks workaround.
Message-ID: <20030226162944.GA15163@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <200302261349.h1QDn06X002823@deviant.impure.org.uk> <200302261627.h1QGREw17937@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302261627.h1QGREw17937@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 11:27:14AM -0500, Alan Cox wrote:
 > > Aparently on rev6 of the LE and above, this workaround
 > > isn't needed. Lets give it a try, and see what happens
 > 
 > Only if serverworks confirm the rumour. This is a corruptor.

I've reports of people with rev6's who have reported success
with that workaround commented out.  Could be they never
pushed the machine hard enough to trigger a bug, but I'd
have thought this breakage would show up pretty quickly.

My attempts to contact serverworks in the past have fallen on
deaf ears. maybe you have better luck ?

        Dave

