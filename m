Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVDDPQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDDPQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVDDPQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:16:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7612 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261260AbVDDPQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:16:27 -0400
Date: Mon, 4 Apr 2005 07:02:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
Cc: Christophe Lucas <clucas@rotomalug.org>, linux-kernel@vger.kernel.org
Subject: Re: ChangeLog-2.4.30
Message-ID: <20050404100212.GA28137@logos.cnet>
References: <20050404074823.GC28840@rhum.iomeda.fr> <42514555.1070205@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42514555.1070205@seznam.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The files are there now, as they should.
                                                                                                                                                                 
[marcelo@logos marcelo]$ wget http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.30.tar.bz2
--06:59:59--  http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.30.tar.bz2
           => `linux-2.4.30.tar.bz2'
Resolving www.kernel.org... 204.152.189.116
Connecting to www.kernel.org[204.152.189.116]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 31,136,728 [application/x-bzip2]
 
 0% [                                     ] 26,064        29.81K/s

Dunno why they were missing before - probably some delay in the kernel.org 
mirroring/archiving system.

On Mon, Apr 04, 2005 at 03:47:01PM +0200, kern.petr@seznam.cz wrote:
> These files missing too:
> http://www.kernel.org/pub/linux/kernel/v2.4/patch-2.4.30.bz2
> http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.30.tar.bz2
