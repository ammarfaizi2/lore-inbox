Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTDXF1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTDXF1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:27:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264411AbTDXF1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:27:43 -0400
Date: Thu, 24 Apr 2003 06:39:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424053950.GV10374@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0304232146020.19326-100000@home.transmeta.com> <3EA76FFE.5070007@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA76FFE.5070007@tequila.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 02:02:54PM +0900, Clemens Schwaighofer wrote:
 
> Point for me is, that with a DRM you could 100% verify that foreign
> module Y is 100% from company Z. Or that binary product F is 100% from
> the company and can be trusted to run here or there.

Excuse me, but I don't get the last part.  You know that
	F had been built in environment of unspecified degree of security
	from source that had been kept in <--->
	written by programmers you don't know
	who had been hired in conformace with criteria <--->
	and released after passing QA of unknown quality (but you can bet
that they had missed some security holes in the past)
	under a license that almost certainly disclaims any responsibility.

Care to explain how does one get from the trust in above to "trusted to run"?
