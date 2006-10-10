Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWJJXhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWJJXhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWJJXhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:37:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932271AbWJJXhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:37:07 -0400
Date: Tue, 10 Oct 2006 16:37:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010163702.d71076c2.akpm@osdl.org>
In-Reply-To: <17708.10335.310098.583695@cargo.ozlabs.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452BE1DC.9030503@goop.org>
	<20061010122511.8232e9d5.akpm@osdl.org>
	<17708.10335.310098.583695@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 09:10:23 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Andrew Morton writes:
> 
> > My plan was to pathetically spam the powerpc guys with it once all the
> > above is merged up.  I took a close look and couldn't see why it was
> > failing.
> 
> What was the failure?
> 

White-screen hang after "returning from prom_init".

I'll merge Jeremy's latest patches and retest this evening.
