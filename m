Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVDJJkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVDJJkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 05:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVDJJkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 05:40:19 -0400
Received: from levante.wiggy.net ([195.85.225.139]:35815 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261456AbVDJJkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 05:40:10 -0400
Date: Sun, 10 Apr 2005 11:40:08 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Christopher Li <lkml@chrisli.org>
Cc: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050410094007.GC28436@wiggy.net>
Mail-Followup-To: Christopher Li <lkml@chrisli.org>,
	Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <20050410055340.GB13853@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410055340.GB13853@64m.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Christopher Li wrote:
> Rename should just work.  It will create a new tree object and you
> will notice that in the entry that changed, the hash for the blob
> object is the same.

What if you rename and change a file within a changeset?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
