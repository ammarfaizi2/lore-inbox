Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262082AbTCZUT7>; Wed, 26 Mar 2003 15:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbTCZUT7>; Wed, 26 Mar 2003 15:19:59 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:47779 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262082AbTCZUT6>; Wed, 26 Mar 2003 15:19:58 -0500
Date: Wed, 26 Mar 2003 20:30:48 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       James Bourne <jbourne@hardrock.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030326203042.GA31359@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	James Bourne <jbourne@hardrock.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <3E7E4C63.908@gmx.de> <Pine.LNX.4.44.0303231717390.19670-100000@cafe.hardrock.org> <20030324003946.GA11081@wohnheim.fh-wedel.de> <3E7E736D.4020200@zytor.com> <20030324144219.GC29637@suse.de> <20030327074727.GA3021@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327074727.GA3021@zaurus.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 08:47:27AM +0100, Pavel Machek wrote:

 > > and have it wget patches from k.o, verify signatures and auto-apply them,
 > > which removes the "admin didnt even know there were patches
 > > that needed to be applied" possibility.
 > 
 > That looks like ugly can of worms to me.
 > "what kernel do you have?"
 > "2.4.25 and it did two downloads; I was
 > compiling it on the friday night"

So make one of the patches change extra-version to -errataN or the like.

		Dave

