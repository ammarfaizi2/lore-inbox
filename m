Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWB0TaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWB0TaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWB0TaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:30:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18322
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751745AbWB0TaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:30:07 -0500
Date: Mon, 27 Feb 2006 11:30:09 -0800
From: Greg KH <gregkh@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227193009.GC9690@suse.de>
References: <20060227190150.GA9121@kroah.com> <8C0F522E-E21E-40DD-8EFA-6D1111AF4CA1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C0F522E-E21E-40DD-8EFA-6D1111AF4CA1@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 01:22:05PM -0600, Kumar Gala wrote:
> It would be nice if we can come up with some way for Linus to  
> document state changes in his release notes.

The diffstat in the directories Documentation/ABI/ would give that for
whomever wants to read it.

thanks,

greg k-h
