Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUBJT0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUBJT0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:26:23 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:48098 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266139AbUBJT0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:26:02 -0500
Date: Tue, 10 Feb 2004 19:23:25 +0000
From: Dave Jones <davej@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Matt Mackall <mpm@selenic.com>,
       Pavel Machek <pavel@suse.cz>, akpm@osdl.org, george@mvista.com,
       Andi Kleen <ak@suse.de>, jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040210192325.GC12634@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tom Rini <trini@kernel.crashing.org>,
	"Amit S. Kale" <amitkale@emsyssoft.com>,
	Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@suse.cz>,
	akpm@osdl.org, george@mvista.com, Andi Kleen <ak@suse.de>,
	jim.houston@comcast.net,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040127184029.GI32525@stop.crashing.org> <20040209155013.GF5219@smtp.west.cox.net> <20040209173828.GG2315@waste.org> <200402101327.40378.amitkale@emsyssoft.com> <20040210084605.GA27889@redhat.com> <20040210192234.GL5219@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210192234.GL5219@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 12:22:34PM -0700, Tom Rini wrote:
 > > generated using bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
 > > It's a tenth of the size. Look better ?
 > That looks about right (and much of that is the netpoll stuff).

cool. snapshotting script updated accordingly.

		Dave

