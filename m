Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWCPShO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWCPShO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWCPShO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:37:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30479 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932706AbWCPShM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:37:12 -0500
Date: Thu, 16 Mar 2006 19:37:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tejun Heo <htejun@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Petr Vandrovec <petr@vandrovec.name>, linux-kernel@vger.kernel.org,
       sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
Message-ID: <20060316183703.GB21003@mars.ravnborg.org>
References: <20060312172511.GA17936@vana.vc.cvut.cz> <20060312174250.GA1470@mars.ravnborg.org> <44150CD7.604@yahoo.com.au> <20060313091254.GA28231@mars.ravnborg.org> <44154DAC.6050006@yahoo.com.au> <20060313163041.GA29719@mars.ravnborg.org> <4419AEEA.50702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4419AEEA.50702@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 03:31:06AM +0900, Tejun Heo wrote:
 Wouldn't it be better to have an option to tell make to assume the old 
> behavior? I only skimmed the original thread but it didn't seem terribly 
> complex thing to do. A LOT of people will be doing things on pre-2.6.17 
> kernel for quite some time and they will be cursing a lot if they have 
> to rebuild everything everytime.

If Paul planned for a new make relase this year - then yes.
But I assume it will take another year (almost) before next make realse
after the current 3.81. And then it should not matter much.

	Sam
