Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265004AbTFCN0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbTFCN0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:26:09 -0400
Received: from holomorphy.com ([66.224.33.161]:16550 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265004AbTFCN0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:26:07 -0400
Date: Tue, 3 Jun 2003 06:39:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030603133925.GG20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com> <20030603123256.GG1253@admingilde.org> <20030603124501.GB13838@suse.de> <bbi77j$mb3$1@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbi77j$mb3$1@tangens.hometree.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 01:18:43PM +0000, Henning P. Schmiedehausen wrote:
> <sarcasm>
> Bah, all this newfangled crap like ctags. We've used grep for 30 years
> and there is no reason to change this now. 
> </sarcasm>
> Dave, the arguments some people bring to simply cling to their
> formatting reminds me of the arguments that the church had in the 14th
> century to still prove that the sun revolves around the earth. Simply
> ignore them. I'm grateful that there are programming environments
> beyond vi. [1] :-)
> 	Regards
> 		Henning
> [1] emacs 

Spraying garbage all over source code destroys editor agnosticism, even
if some editor exists that can hide all the crap like trailing
whitespace, spaces where tabs belong, and screwed-up indentation. Use
emacs all you want. Don't force others to use some particular editor by
spewing garbage all over the kernel source that requires some special
editor to hide.


-- wli
