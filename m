Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946025AbWJZXrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946025AbWJZXrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946029AbWJZXrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:47:16 -0400
Received: from c60.cesmail.net ([216.154.195.49]:45142 "EHLO c60.cesmail.net")
	by vger.kernel.org with ESMTP id S1946025AbWJZXrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:47:15 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Pavel Roskin <proski@gnu.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061026230002.GR27968@stusta.de>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <1161859199.12781.7.camel@localhost.localdomain>
	 <1161890340.9087.28.camel@dv> <20061026214600.GL27968@stusta.de>
	 <1161901793.9087.110.camel@dv>  <20061026230002.GR27968@stusta.de>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 19:47:13 -0400
Message-Id: <1161906433.9087.121.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 01:00 +0200, Adrian Bunk wrote:
> On Thu, Oct 26, 2006 at 06:29:53PM -0400, Pavel Roskin wrote:
> > On Thu, 2006-10-26 at 23:46 +0200, Adrian Bunk wrote:
> >...
> > > It's not even clear that any modules containing non-GPL'ed code were 
> > > legal.
> > 
> > I'm not a lawyer, but I think one cannot classify software as legal or
> > illegal.
> 
> That's wrong, e.g. in some jurisdictions writing software that 
> circumvents copyright protections is forbidden by law.

Fortunately, it would take a long flight of imagination to classify
ndiswrapper as "software that circumvents copyright protections".  One
would have to claim that ndiswrapper is "bundling" itself with non-free
code and "distributing" that "bundle" from the hard drive into RAM, or
something just as ridiculous.

Anyway, I'm glad that the sanity has prevailed for now.

-- 
Regards,
Pavel Roskin

