Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTJXNGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 09:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTJXNGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 09:06:10 -0400
Received: from intra.cyclades.com ([64.186.161.6]:18364 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262181AbTJXNGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 09:06:08 -0400
Date: Fri, 24 Oct 2003 11:02:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: John Wong <kernel@implode.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine on 2.4.23-pre6 Too much work at interrupt, status=0x00001000.
 (fwd)
In-Reply-To: <20031023042349.GA6861@gambit.implode.net>
Message-ID: <Pine.LNX.4.44.0310241101320.1354-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Oct 2003, John Wong wrote:

> Could the problem detailed in the thread:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106687979128274&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106688008628516&w=2
> 
> with reference to 8390-based drivers affect the via-rhine driver? 

No this is a different bug.

In previous message you said 2.4.22 also was spitting "too much work at 
interrupt". Correct? 

Which kernel works on this box?

