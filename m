Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTLLTom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTLLTom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:44:42 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:49669 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261892AbTLLTol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:44:41 -0500
Date: Fri, 12 Dec 2003 20:44:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031212194439.GB11215@win.tue.nl>
References: <20031212131704.A26577@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212131704.A26577@animx.eu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 01:17:04PM -0500, Wakko Warner wrote:

> Is there anyway to get kernel 2.6 to use the geometry
> the bios has for an IDE drive?

The kernel does not use any geometry.

> I have a installation setup that installs a non-linux os and I partition the
> drive under linux.  In 2.4 this has worked flawlessly, however, 2.6 reports
> as # cylinders/16 heads/63 sectors.

Aha. So your real question is:
"Is there any way to get *fdisk to use my favorite geometry?"
The answer is: all common fdisk versions allow you to set the geometry.

Andries

