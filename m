Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTFKPO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTFKPO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:14:29 -0400
Received: from mail0.ewetel.de ([212.6.122.10]:24793 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S262456AbTFKPOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:14:25 -0400
Date: Wed, 11 Jun 2003 17:27:58 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Larry McVoy <lm@bitmover.com>
cc: Ben Collins <bcollins@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK-CVS gateway] version tags
In-Reply-To: <20030611150506.GB20493@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0306111724490.3502-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003, Larry McVoy wrote:

> "Wise" is a stretch, more like a fortunate scripting screwup.  But I agree
> with Ben, given that you can get the info another way it is a lot easier
> (i.e., thrashes the disk less) if we leave it as is.

I didn't notice there are still tags on the ChangeSet file. That's good
enough for me to use. :) It also makes rsync'ing the repositories a little
bit faster since rsync doesn't have to touch all files in case of a new
tag appearing.

Keep up the good work!

-- 
Ciao,
Pascal

