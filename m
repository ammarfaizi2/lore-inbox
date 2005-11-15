Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVKOXk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVKOXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKOXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:40:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965078AbVKOXk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:40:28 -0500
Date: Tue, 15 Nov 2005 18:40:07 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051115234007.GO17023@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115233201.GA10143@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 12:32:01AM +0100, Pavel Machek wrote:

 > If this goes in, you can still keep using old method... I'll not
 > remove it anytime soon.

Ok.

 > > Even it were not for this, the whole idea seems misconcieved to me
 > > anyway.
 > 
 > ...but how do you provide nice, graphical progress bar for swsusp
 > without this? People want that, and "esc to abort", compression,
 > encryption. Too much to be done in kernel space, IMNSHO.
 
I'll take "rootkit doesnt work" over "bells and whistles".

I think most users actually care more about "works" than
"looks pretty, and then fails spectacularly".

		Dave

