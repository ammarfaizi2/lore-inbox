Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTFCAZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264338AbTFCAZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:25:00 -0400
Received: from vitelus.com ([64.81.243.207]:30732 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S264312AbTFCAY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:24:59 -0400
Date: Mon, 2 Jun 2003 17:37:39 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BKCVS issue
Message-ID: <20030603003739.GG14878@vitelus.com>
References: <20030602211436.GF14878@vitelus.com> <200306021937.03013.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306021937.03013.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 07:37:02PM -0400, Rob Landley wrote:
> On Monday 02 June 2003 17:14, Aaron Lehmann wrote:
> > For the past few days, it seems like every time something changes in
> > BK, the bkcvs repository has all of its files touched. At least, all
> > files in the repository have a P preceding their names on a cvs up.
> >
> > It's not intolerable, but I was wondering if anyone's aware of it.
> 
> CVS thinks of changes as having been applied in a certain order, with each 
> cange applying to the result of previous changes.

I understand that they are built on different models, but I had
thought the bk->cvs translator was somewhat intelligent. I had never
seen all the files in the CVS repository touched until a few days ago.
That's why I brought this up.
