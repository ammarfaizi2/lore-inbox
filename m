Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUJRTHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUJRTHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUJRTHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:07:19 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:35427 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267565AbUJRTG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:06:56 -0400
Date: Mon, 18 Oct 2004 23:07:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH to fix depmod failure for modules-install of a cross compiled kernel. (fwd)
Message-ID: <20041018210723.GB16283@mars.ravnborg.org>
Mail-Followup-To: Mark Fortescue <mark@mtfhpc.demon.co.uk>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10410181905110.29938-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10410181905110.29938-100000@mtfhpc.demon.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 07:07:07PM +0100, Mark Fortescue wrote:
> 
> Hi all,
> 
> I ran into a small but inconvinient problem today when doing a
> modules-install. The tempory solution is do disable depmod
> when corss compiling. See the patch below.

I rather keep the present situation in the hope that either depmod is
fixed, or functionality implemented where it blelongs.

	Sam
