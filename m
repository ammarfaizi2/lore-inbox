Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVAILGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVAILGV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 06:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVAILGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 06:06:21 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262037AbVAILGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 06:06:17 -0500
Date: Sun, 9 Jan 2005 12:08:05 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Cc: michal@feix.cz
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
Message-ID: <20050109110805.GA8688@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org, michal@feix.cz
References: <41E0F76D.7080805@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E0F76D.7080805@feix.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 10:20:45AM +0100, Michal Feix wrote:
> Hello evereyone!
> 
> First, I'm not on kernel mailing list so please CC any replies to me. 
> Thank you.
> 
> Yesterday I was recompiling my Linux from Scratch distribution for the 
> first time with Linux kernel 2.6.10 headers as a base for glibc. I've 
> found, that glibc (and XOrg later on too) won't compile, as there is a 
> conflict in certain functions or macros that glibc and Kernel headers 
> both define.

 Are you using proper kernel headers - from
http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ ?

-- 
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."

