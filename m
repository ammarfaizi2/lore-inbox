Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbTGVTHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbTGVTHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:07:16 -0400
Received: from athmta05.forthnet.gr ([193.92.150.26]:3371 "EHLO forthnet.gr")
	by vger.kernel.org with ESMTP id S267317AbTGVTHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:07:15 -0400
Date: Tue, 22 Jul 2003 22:21:38 +0300
From: michaelm <admin@www0.org>
To: Samuel Flory <sflory@rackable.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Charles Lepple <clepple@ghz.cc>,
       michaelm <admin@www0.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Make menuconfig broken
Message-ID: <20030722192138.GA559@www0.org>
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc> <3F1C8739.2030707@rackable.com> <3F1C888B.8040500@rackable.com> <Pine.LNX.4.44.0307221146120.714-100000@serv> <3F1D7BBF.8070202@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1D7BBF.8070202@rackable.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:00:31AM -0700, Samuel Flory wrote:
>   Is it too much to ask to make the defaults give us a working 
> console?  Otherwise we will be answering the question of "why does 
> screen go blank after uncompressing" for the entire 2.6 cycle!!

I'm the 'beginner' that started the thread and I was wondering what *I*
wanted to have in place. Well, I don't think the way the scripts work
now should change, that would make an ugly newbiefication on something
that works. On the other hand as already mentioned, 'if you need
keyboard support at boot, then you just need to include keyboard support
into the kernel' which I guess is a good way into pushing the use of
some common sense. Also the problem is probably here partly because
people are used to older kernel configs which brings two thoughts.
Firstly, people who are compiling 2.5 are *supposed* to have some
experience and secondly, people using 2.6 will eventually learn how to
use the new features.

Some '*** WARNING:'s would the job without making the scripts
too newbiefied IMO. Most linux end-users don't compile kernels
in these days and the ones that do, prefer rawness.

- end of message
