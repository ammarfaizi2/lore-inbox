Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTLWO4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTLWO4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 09:56:32 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:38853 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265147AbTLWO4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 09:56:31 -0500
Date: Tue, 23 Dec 2003 09:24:04 -0500
From: Ben Collins <bcollins@debian.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0ben1 + ieee1394 (snapshot from yesterdays svn repos) -> works
Message-ID: <20031223142404.GY6607@phunnypharm.org>
References: <1072162924.2803.462.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072162924.2803.462.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 08:02:04AM +0100, Soeren Sonnenburg wrote:
> Hi!
> 
> I just wanted to send kudos, as this version seems to be the first one
> which does not generate a kernel panik just from the very start. It was
> also possible to transfer ~20GB (firewire attached ide-hd) via the sbp2
> module and then removing the sbp2/ohci1394/ieee1394 module several times
> without it oopsing (that was enough last time I checked to generate a
> kernel panik!)

Thanks for the feedback.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
