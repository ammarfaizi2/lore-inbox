Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTLPNxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTLPNxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:53:07 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:14901 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261731AbTLPNxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:53:05 -0500
Date: Tue, 16 Dec 2003 14:53:06 +0100
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031216135306.GA7292@iliana>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031212194439.GB11215@win.tue.nl>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 08:44:39PM +0100, Andries Brouwer wrote:
> On Fri, Dec 12, 2003 at 01:17:04PM -0500, Wakko Warner wrote:
> 
> > Is there anyway to get kernel 2.6 to use the geometry
> > the bios has for an IDE drive?
> 
> The kernel does not use any geometry.
> 
> > I have a installation setup that installs a non-linux os and I partition the
> > drive under linux.  In 2.4 this has worked flawlessly, however, 2.6 reports
> > as # cylinders/16 heads/63 sectors.
> 
> Aha. So your real question is:
> "Is there any way to get *fdisk to use my favorite geometry?"
> The answer is: all common fdisk versions allow you to set the geometry.

I believe parted does not. Nor any of the libparted frontends. I may be
wrong though.

Friendly,

Sven Luther
