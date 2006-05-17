Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWEQAjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWEQAjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWEQAja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:39:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62436 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932367AbWEQAj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:39:29 -0400
Date: Tue, 16 May 2006 20:39:27 -0400
From: Dave Jones <davej@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060517003927.GA13465@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <200605152037.54242.ak@suse.de> <1147719901.6623.78.camel@localhost.localdomain> <200605152111.20693.ak@suse.de> <e4b1ha$e1b$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b1ha$e1b$1@terminus.zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 04:06:18PM -0700, H. Peter Anvin wrote:
 > Followup to:  <200605152111.20693.ak@suse.de>
 > By author:    Andi Kleen <ak@suse.de>
 > In newsgroup: linux.dev.kernel
 > > 
 > > > x86 is a legacy architecture now anyway, right? ;)
 > > I wish everybody would agree on that @)
 > > 
 > 
 > It's going to live on for a very long time, though.  Intel is still
 > shipping some very fast 64-bit-deficient silicon.  Once that's gone,
 > it's going to live on for decades in the embedded world.

There's also a surprising number of people still running
their shiny new x86-64's in 32 bit mode.  (I suspect because
they're reliant upon applications that aren't 64-bit clean
that for whatever reason don't run in 32-bit emulation).

I'd be surprised if any of the major distros stopped shipping
a 32-bit x86 release for several years.

		Dave

-- 
http://www.codemonkey.org.uk
