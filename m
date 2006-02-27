Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWB0W63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWB0W63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWB0W62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:58:28 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:8720 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932498AbWB0W61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:58:27 -0500
Date: Mon, 27 Feb 2006 23:58:26 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Benjamin LaHaise <bcrl@kvack.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227225826.GC85023@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
	Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <1141071050.2992.159.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141071050.2992.159.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 09:10:50PM +0100, Arjan van de Ven wrote:
> if it's this volatile, the lib should come with the kernel.

The ALSA lib would never be accepted anywhere near the kernel.

  OG.

