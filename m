Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWG0T42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWG0T42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWG0T42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:56:28 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:58001 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751011AbWG0T41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:56:27 -0400
Message-ID: <1154030149.44c91a453d6b0@portal.student.luth.se>
Date: Thu, 27 Jul 2006 21:55:49 +0200
From: ricknu-0@student.ltu.se
To: Nicholas Miell <nmiell@comcast.net>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
References: <1153341500.44be983ca1407@portal.student.luth.se>  <1153945705.44c7d069c5e18@portal.student.luth.se>  <200607270448.03257.arnd.bergmann@de.ibm.com> <1153978047.2807.5.camel@entropy>
In-Reply-To: <1153978047.2807.5.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Nicholas Miell <nmiell@comcast.net>:

> If _Bool does end up in the user-kernel ABI, be advised that validating
> them will be tricky ("b == true || b == false" or "!!b" won't work), and

Why would !!b not work?
I don't think it should end up in the ABI (at least, not yet). Just asking
because I'm curious. :)

> Nicholas Miell <nmiell@comcast.net>

/Richard Knutsson

