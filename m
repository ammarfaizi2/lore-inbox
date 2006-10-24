Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWJXHlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWJXHlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWJXHli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:41:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:50311 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752107AbWJXHli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:41:38 -0400
Date: Tue, 24 Oct 2006 00:40:55 -0700
From: Greg KH <greg@kroah.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061024074055.GA22375@kroah.com>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610201339.49190.m.kozlowski@tuxland.pl> <20061020091901.71a473e9.akpm@osdl.org> <200610201854.43893.m.kozlowski@tuxland.pl> <20061020102520.67b8c2ab.akpm@osdl.org> <20061023095840.051bff42@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023095840.051bff42@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 09:58:40AM +0200, Cornelia Huck wrote:
> On Fri, 20 Oct 2006 10:25:20 -0700,
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Ow.  Multithreaded probing was probably a bt ambitious, given the current
> > status of kernel startup..
> 
> IMHO, multithreaded probing as currently implemented doesn't look sane.
> See http://marc.theaimsgroup.com/?l=linux-kernel&m=116108334418165&w=2
> for my take on it...

Yes, I like your patches, they are in my queue still, hopefully I can
get to them soon, but will be in meetings for the next few days.

Hm, actually, I might be able to get some work done like this because I
will be in meetings :)

thanks for your patience,

greg k-h
