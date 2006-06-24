Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWFXVrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWFXVrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFXVrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:47:36 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:21945 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751101AbWFXVrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:47:36 -0400
Date: Sat, 24 Jun 2006 23:47:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org,
       kai@germaschewski.name
Subject: Re: modpost change proposed
Message-ID: <20060624214727.GA8904@mars.ravnborg.org>
References: <20060623113138.GA29844@kestrel.barix.local> <20060623121250.GG14682@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623121250.GG14682@harddisk-recovery.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 02:12:51PM +0200, Erik Mouw wrote:
> > 
> > I suggest the abort(); to be everywhere replaced with exit(1) for the
> > following reasons:
> > 1) it's customary
Did so in scripts/* - thanks.

	Sam
