Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVGGMRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVGGMRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVGGMP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:15:26 -0400
Received: from [203.171.93.254] ([203.171.93.254]:65193 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261295AbVGGMOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:14:02 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz>
	 <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost>
	 <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120738525.4860.1433.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Jul 2005 22:15:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-07-07 at 22:04, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> 
> > I've been thinking about this some more and wondering whether I should
> > just replace swsusp. I really don't want to step on your toes though.
> > What would you like to see happen?
> 
> Do you implement the entire swsusp userspace interface? If not, removing
> it probably isn't a reasonable plan without fair warning.

I'm not suggesting removing the sysfs interface or replacing system to
ram - just the suspend to disk part.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

