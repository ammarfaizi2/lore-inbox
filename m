Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTEFMo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbTEFMo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:44:56 -0400
Received: from home.wiggy.net ([213.84.101.140]:25542 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262722AbTEFMoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:44:55 -0400
Date: Tue, 6 May 2003 14:57:26 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 just doesn't boot (neither does anything > .67)
Message-ID: <20030506125726.GH20419@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030506124249.GG20419@wiggy.net> <Pine.LNX.4.44.0305062230420.2201-100000@bad-sports.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305062230420.2201-100000@bad-sports.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Brett wrote:
> linuxfromscratch system
> unless they fix the source compilation problem i reported
> <http://savannah.gnu.org/bugs/?func=detailbug&bug_id=3343&group_id=68>
> then i can't install it

You can always install manually. 

> and anyway, can you provide any backup that this will fix it ?? what 
> changed between 2.5.66 and 2.5.67 to stop grub loading the kernel ? why 
> hasn't anyone else reported this ???

I couldn't boot 2.5 at all until I upgraded an ancient grub. Having
a recent bootloader is never a bad thing though, and 0.92 is pretty
old.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

