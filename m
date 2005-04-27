Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVD0WIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVD0WIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVD0WIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:08:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9866 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262047AbVD0WI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:08:26 -0400
Date: Thu, 28 Apr 2005 00:08:16 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Erik Tews <erik@debian.franken.de>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [04/07] partitions/msdos.c fix
Message-ID: <20050427220816.GA5428@apps.cwi.nl>
References: <20050427171446.GA3195@kroah.com> <20050427171627.GE3195@kroah.com> <20050427203440.GA26759@apps.cwi.nl> <1114634968.18249.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114634968.18249.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 10:49:28PM +0200, Erik Tews wrote:

> But this should only affect the first 512 bytes of my harddisk, or? If
> so, I can copy this data and send it to you.

Yes, please do.

(There are various ways in which more data could be involved,
but the first sector is a good start.)

Andries
