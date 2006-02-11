Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWBKQhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWBKQhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 11:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBKQhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 11:37:19 -0500
Received: from mail2.pipni.cz ([193.86.238.4]:3486 "EHLO mail2.pipni.cz")
	by vger.kernel.org with ESMTP id S932150AbWBKQhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 11:37:18 -0500
From: Jan Merka <merka@highsphere.net>
To: suspend2-devel@lists.suspend2.net
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 11 Feb 2006 11:36:56 -0500
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz>
In-Reply-To: <20060210233507.GC1952@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111136.56325.merka@highsphere.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 18:35, Pavel Machek wrote:
> Anyway, it means that suspend is still quite a hot topic, and that is
> good. (Linus said that suspend-to-disk is basically for people that
> can't get suspend-to-RAM to work, and after I got suspend-to-RAM to
> work reliably here, I can see his point).

I strongly disagree. I got suspend-to-RAM to work but its utility is seriously 
limited by battery capacity. For example, on my laptop (Sony VGN-B100B) with 
1.5GB of RAM, a fully charged battery is drained in about 18 hours if the 
laptop was suspended to RAM. 

Yes, for a few hours suspend-to-RAM is convenient but suspend-to-disk is 
_reliable_ and _safe_.

Jan
