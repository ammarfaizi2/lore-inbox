Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVBQE6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVBQE6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVBQE6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:58:20 -0500
Received: from thunk.org ([69.25.196.29]:57500 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262213AbVBQE6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:58:06 -0500
Date: Wed, 16 Feb 2005 23:57:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Olivier Galibert <galibert@pobox.com>, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050217045743.GB6115@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Clemens Schwaighofer <cs@tequila.co.jp>,
	Olivier Galibert <galibert@pobox.com>, kernel@crazytrain.com,
	linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com> <20050214185624.GA16029@bitmover.com> <1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp> <20050216154321.GB34621@dspnet.fr.eu.org> <4213E141.5040407@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4213E141.5040407@tequila.co.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 09:11:45AM +0900, Clemens Schwaighofer wrote:
> 
> first. what kind of advantages does bk have over other svn? Seriously.
> If Apache can use it, and gcc might use it (again two very large
> projects), what makes linux so differetnt that it can't.

Compare the number of developers, the number of overlapping
simultaneous development trees, and the number of patches that touch
overlapping files, and you'll begin to start to appreciate the
difference between a system that can work for Linux, and a system that
can working for simpler projects.

						- Ted
