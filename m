Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbTCXDoW>; Sun, 23 Mar 2003 22:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264084AbTCXDoW>; Sun, 23 Mar 2003 22:44:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44819
	"EHLO x30.random") by vger.kernel.org with ESMTP id <S262911AbTCXDoW>;
	Sun, 23 Mar 2003 22:44:22 -0500
Date: Sun, 23 Mar 2003 22:54:49 -0500
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <jgarzik@pobox.com>,
       James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
       arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324035449.GK1449@x30.local>
References: <1240000.1048460079@[10.10.2.4]> <200303232319.h2NNJqs13257@devserv.devel.redhat.com> <20030324033505.GJ1449@x30.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324033505.GJ1449@x30.local>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 10:35:05PM -0500, Andrea Arcangeli wrote:
> nothing I would call major or very significant. Maybe if you merge them,

woops, re-reading I said the above plain wrong sorry, I really meant
they're not going to give you major or very significant problems in
merging (at least IMHO but I may be biased ;), for the big iron
_end_users_ they are definitely significant this is why I'm recommending
their merging and various other people is pushing for their merging in
mainline too.

Andrea
