Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271778AbTGRPGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271841AbTGRPGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:06:11 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:16847 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271775AbTGRO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:58:28 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 18 Jul 2003 17:13:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: mason@suse.com, andrea@suse.de, riel@redhat.com,
       linux-kernel@vger.kernel.org, maillist@jg555.com
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-Id: <20030718171322.1b7e752c.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0307181109220.7889@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva>
	<1058297936.4016.86.camel@tiny.suse.com>
	<Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva>
	<20030718112758.1da7ab03.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva>
	<20030718145033.5ff05880.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307181109220.7889@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 11:14:15 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> I have just started stress testing a 8way OSDL box to see if I can
> reproduce the problem. I'm using pre6+axboes BH_Sync patch.
> 
> I'm running 50 dbench clients on aic7xxx (ext2) and 50 dbench clients on
> DAC960 (ext3). Lets see what happens.
> 
> After lunch I'll keep looking at the oopses. During the morning I only had
> time to setup the OSDL box and start the tests.

On my box it takes about 48 hours before the problem shows. But that may
heavily depend on the box I guess.

Regards,
Stephan

