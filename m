Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVG2KxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVG2KxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVG2KxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:53:04 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:62669 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262576AbVG2Kwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:52:49 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.13-rc3-mm2/mm1 breaks DRI
Date: Fri, 29 Jul 2005 06:52:44 -0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050727024330.78ee32c2.akpm@osdl.org> <200507282037.52292.tomlins@cam.org> <21d7e9970507281741fb51c98@mail.gmail.com>
In-Reply-To: <21d7e9970507281741fb51c98@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507290652.44418.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 July 2005 20:41, Dave Airlie wrote:
> > > >
> > > >Hmm no idea what could have broken it, I'm at OLS and don't have any
> > > >DRI capable machine here yet.. so it'll be a while before I get to
> > > >take a look at it .. I wouldn't be terribly surprised if some of the
> > > >new mapping code might have some issues..
> > >
> > > Still happens with mm2.
> > 
> > And mm3 too.  Please let me know if there is anything you would like me to try.
> 
> Hi Ed,
> 
> Is this all on a 64-bit system, is it a pure 64-bit or are you running
> a 32-bit userspace or something like that... I don't have any 64-bit
> systems so tracking the issues on them is a nightmare...

Its all 64bit... 

> I've got a patch from Egbert Eich that I need to drop into -mm that
> might fix it but I'm snowed under with real work at the moment (taking
> a week off for OLS didn't help :-)

Pass me the patch.  If I can get it to apply I will gladly try it.  Real work is
always 'fun'...

Ed Tomlinson 
