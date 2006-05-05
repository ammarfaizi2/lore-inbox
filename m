Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWEEDXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWEEDXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 23:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEEDXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 23:23:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22146 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932461AbWEEDXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 23:23:07 -0400
Date: Thu, 4 May 2006 20:25:54 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.14
Message-ID: <20060505032554.GC24291@moss.sous-sol.org>
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051152.39693.ncunningham@cyclades.com> <20060505023353.GA24291@moss.sous-sol.org> <200605051303.37130.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051303.37130.ncunningham@cyclades.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nigel Cunningham (ncunningham@cyclades.com) wrote:
> :) Tongue was firmly in cheek. I guess I should have said more initially. It 

I figured it was a bit tongue in cheek ;-)

> wasn't so much the patch, as the speed with which they're coming. It makes me 
> (at least) feel like the stable series is unstable. Couldn't you store them 
> up for a day or two at a time (unless of course they really are that 
> important that they require a quicker cycle).

Typically we do.  The security patches tend to go out straight away,
unless they are very low risk, at which point they are batched with the
others.  But once we know of a user triggerable security hole, it's
best to release rather than sit on it.

thanks,
-chris
