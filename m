Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSLCMjB>; Tue, 3 Dec 2002 07:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSLCMjB>; Tue, 3 Dec 2002 07:39:01 -0500
Received: from pc3-stoc3-4-cust114.midd.cable.ntl.com ([80.6.255.114]:56073
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S261205AbSLCMjB>; Tue, 3 Dec 2002 07:39:01 -0500
Date: Tue, 3 Dec 2002 12:46:26 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Compile Failure
Message-ID: <20021203124626.GD8351@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20021203120928.GC8351@buzz.ichilton.co.uk> <20021203122238.GD30431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203122238.GD30431@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> compile in the sis frame buffer too. They need each other iirc.


Yes, that fixed it - Thanks!

Maybe it should be made so the SiS DRM option only appears if the SiS
framebuffer is selected?


Bye for Now,

Ian

