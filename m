Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030834AbWI0U6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030834AbWI0U6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030841AbWI0U6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:58:09 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:23771 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1030837AbWI0U6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:58:08 -0400
Date: Wed, 27 Sep 2006 16:58:05 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Kyle McMartin <kyle@parisc-linux.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Message-ID: <20060927205805.GA3262@athena.road.mcmartin.ca>
References: <200609271424.47824.eike-kernel@sf-tec.de> <pan.2006.09.27.17.56.13.80913@automagically.de> <20060927184037.GA3306@athena.road.mcmartin.ca> <p73fyedje0f.fsf@verdi.suse.de> <Pine.LNX.4.64.0609271320580.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609271320580.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 01:21:17PM -0700, Linus Torvalds wrote:
> On Wed, 27 Sep 2006, Andi Kleen wrote:
> > I expect this patch to fix it.
> 
> Andrew, Kyle, can you verify?
> 

Yup, it works. (For reference, it's gcc 4.1.1-13 from Debian.)

Cheers,
	Kyle M.
