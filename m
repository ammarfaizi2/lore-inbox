Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbTBSPaD>; Wed, 19 Feb 2003 10:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268937AbTBSPaD>; Wed, 19 Feb 2003 10:30:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38150 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268936AbTBSPaC>;
	Wed, 19 Feb 2003 10:30:02 -0500
Date: Wed, 19 Feb 2003 16:40:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove checkhelp.pl and header.tk
Message-ID: <20030219154004.GC970@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3E538A98.1010205@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E538A98.1010205@quark.didntduck.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 08:46:00AM -0500, Brian Gerst wrote:
> Changes in the config system have obsoleted these files.
> 

Good!
While add it, did you look at checkconfig.pl.
It seems to spit out a lot of nosie when run, but my perl skills
are not enough to fix it :-(

	Sam

