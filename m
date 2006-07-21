Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWGUMaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWGUMaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWGUMaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:30:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161068AbWGUMaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:30:18 -0400
Date: Fri, 21 Jul 2006 05:29:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: neilb@suse.de, jack@suse.cz, 20@madingley.org,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: Bad ext3/nfs DoS bug
Message-Id: <20060721052924.b3916d95.akpm@osdl.org>
In-Reply-To: <1153442533.5050.1.camel@aeonflux.holtmann.net>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	<1153209318.26690.1.camel@localhost>
	<20060718145614.GA27788@circe.esc.cam.ac.uk>
	<1153236136.10006.5.camel@localhost>
	<20060718152341.GB27788@circe.esc.cam.ac.uk>
	<1153253907.21024.25.camel@localhost>
	<20060719092810.GA4347@circe.esc.cam.ac.uk>
	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	<17599.2754.962927.627515@cse.unsw.edu.au>
	<1153442533.5050.1.camel@aeonflux.holtmann.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 02:42:13 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> I tested your patch and it works for me. So can someone with ext3
> knowledge review and then propose it for upstream inclusion.

Yup, I have it save away for next week's resumption of work.
