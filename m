Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUC0VaE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUC0VaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:30:04 -0500
Received: from gprs214-250.eurotel.cz ([160.218.214.250]:25984 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261875AbUC0V37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:29:59 -0500
Date: Sat, 27 Mar 2004 22:29:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luke-Jr <luke-jr@artcena.com>
Cc: swsusp-devel@lists.sourceforge.net, ncunningham@users.sourceforge.net,
       Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was	Re: Your opinion on the merge?]]
Message-ID: <20040327212946.GB295@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <20040326222234.GE9491@elf.ucw.cz> <1080353285.9264.3.camel@calvin.wpcb.org.au> <200403270337.48704.luke-jr@artcena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403270337.48704.luke-jr@artcena.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On So 27-03-04 03:37:48, Luke-Jr wrote:
> On Saturday 27 March 2004 02:08 am, Nigel Cunningham wrote:
> > On Sat, 2004-03-27 at 10:22, Pavel Machek wrote:
> > > You are right, that would be ugly. How is encryption supposed to work,
> > > kernel asks you to type in a key?
> >
> > I haven't thought about the specifics there. Perhaps the plugin prompts
> > for one, or perhaps it takes a lilo parameter? 
> The only purpose I can think of for encryption would be so someone can't grab 
> the HD and boot it on another PC or read the image directly.
> Unless I'm missing something, that would imply that the key would need to be 
> generated from a hardware profile (only creatable by root) somehow to 
> restrict its readability to that one system.

Hmm, I do not see how hardware hash helps. When I can steal your hdd,
there's good chance I can steal whole machine, too.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
