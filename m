Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVEZQMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVEZQMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVEZQMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:12:02 -0400
Received: from animx.eu.org ([216.98.75.249]:21927 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261593AbVEZQL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:11:59 -0400
Date: Thu, 26 May 2005 12:09:07 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050526160907.GA9672@animx.eu.org>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org> <20050526154509.GB9443@animx.eu.org> <20050526155344.GB3694@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526155344.GB3694@ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, May 26, 2005 at 11:45:09AM -0400, Wakko Warner wrote:
> > I also have a problem with 2.6.12-rcX and ps/2 keyboard.  I would say it's
> > the same key we're talking about.  It does not work at the console nor in X
> > (showkey at the console does not see it).  It works with a USB keyboard.  My
> > "compose" is mapped to the menu key beside the right windows key.
> > 
> > I do wish they'd fix it, because I use this key (kinda like another ALT key)
> > more than my compose key (again, the menu key, not the right win logo key)
>  
> This patch should fix it.

Thanks, I'll try it out and let you know.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
