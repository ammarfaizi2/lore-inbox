Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTEFU4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTEFUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:55:59 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:38662 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261953AbTEFUz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:55:56 -0400
Date: Tue, 6 May 2003 22:08:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
Message-ID: <20030506220828.A19971@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DCF0.2070207@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB7DCF0.2070207@convergence.de>; from hunold@convergence.de on Tue, May 06, 2003 at 06:04:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and your devfs stuff is a mess.  I already told one of the DVB folks
(it wasn't you IIRC) that I'll publish a 2.5 devfs API on 2.4 header.
But first I have to fix the devfs API on 2.5 and randomly bringing
back old crap and lots of ifdefs in those changing areas won't help.

What the problem with 2.5, dvb and devfs? 

