Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbTHESn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbTHESn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:43:57 -0400
Received: from guri.is.kpn.be ([193.74.71.22]:2530 "EHLO guri.is.kpn.be")
	by vger.kernel.org with ESMTP id S269659AbTHESny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:43:54 -0400
Date: Tue, 5 Aug 2003 20:47:01 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
Message-ID: <20030805184701.GA15740@gouv>
References: <200308051242.h75CgSj6028203@harpo.it.uu.se> <1060101338.1189.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060101338.1189.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 05:35:38PM +0100, Alan Cox wrote:
> > 
> > ftape fails on SMP due to sti/save_flags/restore_flags removal.
> 
> The -ac tree has some stuff for this sitting in it but I've not been able to
> find a tester..

I would be happy to test (I have the hardware :( ) but your patch
don't compile due to sti and restore_flags still in ftape/lowlevel

Thanks anyway

