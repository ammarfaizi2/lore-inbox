Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVDEKdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVDEKdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDEJk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:40:28 -0400
Received: from verein.lst.de ([213.95.11.210]:39607 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261672AbVDEJj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:39:28 -0400
Date: Tue, 5 Apr 2005 11:39:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ian Campbell <ijc@hellion.org.uk>, Sven Luther <sven.luther@wanadoo.fr>,
       "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405093902.GA18669@lst.de>
References: <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <20050405093258.GA18523@lst.de> <1112693819.6275.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112693819.6275.36.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:36:58AM +0200, Arjan van de Ven wrote:
> One of the options is to even ship the firmware in the kernel tarbal but
> from a separate directory with a clear license clarification text in it.

I think that's what we should do.  I currently don't have any firmware
requiring devices, but I'd volunteer to keep such a tarball for now if
no one else wants to do tiny amount of work.

