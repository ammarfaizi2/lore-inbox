Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbULFQPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbULFQPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbULFQLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:11:00 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:64154 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261565AbULFQKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:10:39 -0500
Date: Mon, 6 Dec 2004 17:10:32 +0100
From: bert hubert <ahu@ds9a.nl>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Correctly determine amount of "free memory"
Message-ID: <20041206161032.GA4997@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Gregory Giguashvili <Gregoryg@ParadigmGeo.com>,
	linux-kernel@vger.kernel.org
References: <06EF4EE36118C94BB3331391E2CDAAD9CD067A@exil1.paradigmgeo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06EF4EE36118C94BB3331391E2CDAAD9CD067A@exil1.paradigmgeo.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 05:57:09PM +0200, Gregory Giguashvili wrote:

> I'm using mlock(2), but the problem is that I need to allocate as much
> memory as possible without causing swapping, so I need to have _rough_
> estimate before actually allocating the memory.

I think a guy called 'Ben' from google went over this a couple of years ago,
the discussion might still be relevant. His email address contained
'google.com' and he posted on lkml.

Too lazy to google for it now but this will point you in the right
direction.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
