Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUC1Ttw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUC1Ttw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:49:52 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:4114 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262400AbUC1Tta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:49:30 -0500
Date: Sun, 28 Mar 2004 21:49:58 +0200
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Message-ID: <20040328194958.GA6921@hh.idb.hist.no>
References: <20040323232511.1346842a.akpm@osdl.org> <406194D4.9030904@aitel.hist.no> <1080137982.5296.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080137982.5296.0.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 03:19:42PM +0100, Arjan van de Ven wrote:
> On Wed, 2004-03-24 at 15:01, Helge Hafting wrote:
> > Andrew Morton wrote:
> > 
> > 2.6.5-rc2-mm2 hung during boot for me.
> > The last messages was
> > Setting up ICE socket directory ... done
> > 
> > which is from the xserver-common init script
> 
> are you using the nvidia modules ?

No modules whatsoever, I prefer a monolithic kernel
containing drivers for what I have.

I'm using a radeon card for graphichs.

Helge Hafting
