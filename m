Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTEKLDF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 07:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTEKLDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 07:03:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2572 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261218AbTEKLDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 07:03:04 -0400
Date: Sun, 11 May 2003 12:13:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.69] suspend storing signed jiffies
Message-ID: <20030511121325.C29615@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Stephen Hemminger <shemminger@osdl.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030509160505.31cae893.shemminger@osdl.org> <20030510165639.GA238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030510165639.GA238@elf.ucw.cz>; from pavel@suse.cz on Sat, May 10, 2003 at 06:56:40PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 06:56:40PM +0200, Pavel Machek wrote:
> > Gets rid of warning because of using jiffies in int.
> 
> I submitted it through the trivial patch monkey. If linus does not
> apply it, it is easiest just let Russell push it...

Do you mean me?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

