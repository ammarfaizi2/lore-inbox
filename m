Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbTJIO2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJIO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:28:20 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17092 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262276AbTJIO2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:28:18 -0400
Date: Thu, 9 Oct 2003 15:28:04 +0100
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031009142804.GC23545@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F856A7E.2010607@pobox.com> <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet> <20031009141143.GF1232@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009141143.GF1232@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:11:43PM +0200, Jens Axboe wrote:

 > > > Red Hat just dropped this patch since it was suspected of data 
 > > > corruption ;-(
 > > 
 > > Uh, oh... Jens? 
 > 
 > See my previous mail. I don't see any problems with it, and I've
 > certainly not heard of (or experienced myself) problems with the patch.
 > I'm waiting for Jeff to expand on his mail, surely he/RH must know more
 > about this issue.


Laptop mode is likely fine, the problem we've seen is very likely caused
by the AAM counterpart.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
