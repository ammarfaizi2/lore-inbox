Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTEBFb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 01:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbTEBFb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 01:31:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35850 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261805AbTEBFb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 01:31:26 -0400
Date: Fri, 2 May 2003 06:43:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: The Spirit of Open Source <tsoos@scoloses.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Did the SCO Group plant UnixWare source in the Linux kernel?
Message-ID: <20030502064349.A9988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	The Spirit of Open Source <tsoos@scoloses.org>,
	linux-kernel@vger.kernel.org
References: <ZIA7D8S737743.2233333333@Gilgamesh-frog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ZIA7D8S737743.2233333333@Gilgamesh-frog.org>; from tsoos@scoloses.org on Fri, May 02, 2003 at 03:21:36AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 03:21:36AM -0000, The Spirit of Open Source wrote:
> If there's UnixWare source in the Linux kernel, a SCO Group employee put it
> there!  After all, who else would have such easy access to UnixWare sources?

As somone who walked for SCO (or rather Caldera how it was called at that
time) I can tell you this is utter crap.  There were very people actually
doing Linux kernel work then (and when the German office was closed down
all those left the company) and we really had better things to do then
trying to retrofit UnixWare code into the linux kenrel.  Especially given
that the kernel internals are so different that you'd need a big glue
layer to actually make it work and you can guess how that would be
ripped apart in a usual lkml review :)

It might be more interesting to look for stolen Linux code in Unixware,
I'd suggest with the support for a very well known Linux fileystem in
the Linux compat addon product for UnixWare..

