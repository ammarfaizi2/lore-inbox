Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTFDTET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTFDTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:04:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5645 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263859AbTFDTES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:04:18 -0400
Date: Wed, 4 Jun 2003 21:17:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stig Brautaset <stig@brautaset.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: scripts/Makefile.build fix
Message-ID: <20030604191746.GA26743@mars.ravnborg.org>
Mail-Followup-To: Stig Brautaset <stig@brautaset.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <fa.eruk8hn.73g20l@ifi.uio.no> <fa.hcaig7b.n72lar@ifi.uio.no> <20030601222840.GA13170@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601222840.GA13170@brautaset.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 11:28:40PM +0100, Stig Brautaset wrote:
> On Jun 01 2003, Sam wrote:
> > On Sun, Jun 01, 2003 at 07:43:35PM +0100, Stig Brautaset wrote:
> > > Hi, 
> > > 
> > > This patch seems to fix `make V=0' for me.
I sent a slightly different patch to Linus yesterday that is now in
BK-latest.
Let me know if you still see the problem with fixdep.

	Sam
