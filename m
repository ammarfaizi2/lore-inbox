Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUA0AGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUA0AGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:06:48 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:58893 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265613AbUA0AGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:06:47 -0500
Date: Mon, 26 Jan 2004 16:06:45 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
Message-ID: <20040127000645.GE11879@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause drowsiness.  Do not operate heavy machinery.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 11:46:29AM -0600, Michael A Halcrow wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have some time this year to work on an encrypted filesystem for
> Linux.  I have surveyed various LUG's, tested and reviewed code for
> currently existing implementations, and have started modifying some
> of them.  I would like to settle on a single approach on which to
> focus my efforts, and I am interested in getting feedback from the
> LKML community as to which approach is the most feasible.
> 
> This is the feature wish-list that I have compiled, based on personal
> experience and feedback I have received from other individuals and
> groups:

This sounds more like transparent (in-kernel?) file encryption 
than an encrypted filesystem.  I think there is value in
having both, or all three if you add encrypted block devices.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
