Return-Path: <linux-kernel-owner+w=401wt.eu-S1754079AbWLRObX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbWLRObX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 09:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbWLRObX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 09:31:23 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:36745 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082AbWLRObX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 09:31:23 -0500
Date: Mon, 18 Dec 2006 09:31:22 -0500
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: James Porter <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers
Message-ID: <20061218143122.GB8591@csclub.uwaterloo.ca>
References: <loom.20061215T220806-362@post.gmane.org> <20061215215943.622dd456@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215215943.622dd456@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:59:43PM +0000, Alan wrote:
> 3DFx invented SLI many years ago. The SLI programming information for the
> 3DFx cards is public. Nvidia are a bit late to the party except on the PR
> front.

Well they do work differently.  3Dfx just did alternate line rendering,
while nvidia does a lot more methods of dividing the work load (many of
which are likely to be more efficient than alternate line rendering in
general).  No doubt why they picked the name SLI though.  They did also
buy out 3Dfx so I guess by that they can claim to have "invented" it. :)

--
Len Sorensen
