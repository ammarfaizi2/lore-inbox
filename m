Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTBSPWb>; Wed, 19 Feb 2003 10:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbTBSPWb>; Wed, 19 Feb 2003 10:22:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15633 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267692AbTBSPWa>;
	Wed, 19 Feb 2003 10:22:30 -0500
Date: Wed, 19 Feb 2003 16:32:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Arador <diegocg@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: buggy include path?
Message-ID: <20030219153231.GA970@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Arador <diegocg@teleline.es>, linux-kernel@vger.kernel.org
References: <20030219002938.08b717c7.diegocg@teleline.es> <20030218153919.16d41430.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218153919.16d41430.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 03:39:19PM -0800, Randy.Dunlap wrote:
> Can the -Idirname be made more complete, e.g. by using
> $TOPDIR or $MODLIB ... me wonders.
> Or would that just be duplicating the default behavior?
> Anyone?

That would make moving a kernel tree requiring a recompile due to usage
of absolute paths.

	Sam
