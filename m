Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVCKKn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVCKKn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbVCKKn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:43:59 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:38050
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S262658AbVCKKjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:39:15 -0500
Date: Fri, 11 Mar 2005 10:39:12 +0000
From: Ben Dooks <ben@fluff.org>
To: Rik van Riel <riel@redhat.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
Message-ID: <20050311103912.GB16590@home.fluff.org>
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net> <Pine.LNX.4.61.0503101744170.16741@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503101744170.16741@chimarrao.boston.redhat.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 05:45:22PM -0500, Rik van Riel wrote:
> On Thu, 10 Mar 2005, John Richard Moser wrote:
> 
> > A Linux specific binary driver format might be more useful,
> 
> No, it wouldn't.  I can use a source code driver on x86,
> x86-64 and PPC64 systems, but a binary driver is only
> usable on the architecture it was compiled for.

Add to that the flavours of ARM and the number of
bootloaders that are out there.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
