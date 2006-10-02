Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWJBKmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWJBKmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWJBKmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:42:12 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:9481 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750762AbWJBKmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:42:10 -0400
Date: Mon, 2 Oct 2006 12:42:09 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@osdl.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org,
       rossb@google.com, sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Message-ID: <20061002104209.GA90774@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
	rdunlap@xenotime.net, linux-kernel@vger.kernel.org,
	rossb@google.com, sam@ravnborg.org
References: <200610020708.k92788Th007608@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610020708.k92788Th007608@harpo.it.uu.se>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 09:08:08AM +0200, Mikael Pettersson wrote:
> All that's needed is to standardise the location of the
> config file; /lib/modules/`uname -r`/config.gz seems a
> reasonable choice.

It's already /boot/config-`uname -r`, why change?

  OG.
