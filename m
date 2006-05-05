Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWEEFPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWEEFPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWEEFPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:15:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:4271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030336AbWEEFPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:15:02 -0400
Date: Thu, 4 May 2006 22:10:20 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, torvalds@osdl.org,
       Nigel Cunningham <ncunningham@cyclades.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.16.14
Message-ID: <20060505051020.GA3869@kroah.com>
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051152.39693.ncunningham@cyclades.com> <20060505023353.GA24291@moss.sous-sol.org> <200605051303.37130.ncunningham@cyclades.com> <20060505032554.GC24291@moss.sous-sol.org> <20060505033325.GM4776@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505033325.GM4776@zip.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 01:33:25PM +1000, CaT wrote:
> On Thu, May 04, 2006 at 08:25:54PM -0700, Chris Wright wrote:
> > Typically we do.  The security patches tend to go out straight away,
> > unless they are very low risk, at which point they are batched with the
> > others.  But once we know of a user triggerable security hole, it's
> > best to release rather than sit on it.
> 
> I was wondering, will there be another/more stable .15 releases?

I don't think that Chris or I will be doing any, as we don't have any
pending patches against that tree that people have sent us.  If you, or
someone else wants to take over the .15 tree, feel free :)

good luck,

greg k-h
