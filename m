Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUA0TT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUA0TQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:16:41 -0500
Received: from sigint.cs.purdue.edu ([128.10.2.82]:53132 "EHLO
	sigint.cs.purdue.edu") by vger.kernel.org with ESMTP
	id S265751AbUA0TPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:15:00 -0500
Date: Tue, 27 Jan 2004 14:14:58 -0500
From: linux@sigint.cs.purdue.edu
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: Andi Kleen <ak@suse.de>, Rui Saraiva <rmps@joel.ist.utl.pt>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
Message-ID: <20040127191458.GA9595@sigint.cs.purdue.edu>
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel> <p73bropfdgl.fsf@nielsen.suse.de> <200401271251.34926.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401271251.34926.theman@josephdwagner.info>
X-Disclaimer: Any similarity to an opinion of Purdue is purely coincidental
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:51:34PM -0600, Joseph D. Wagner wrote:
> > It seems that many files [1] in the Linux source have lines with
> > trailing blank (space and tab) characters and some even have formfeed
> > characters. Obviously these blank characters aren't necessary.
> 
> Actually, they are necessary.
> 
> http://www.gnu.org/prep/standards_23.html
> http://www.gnu.org/prep/standards_24.html

>From Documentation/CodingStyle:

| First off, I'd suggest printing out a copy of the GNU coding standards,
| and NOT read it.  Burn them, it's a great symbolic gesture. 
