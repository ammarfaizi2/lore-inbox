Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271311AbTHRHJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 03:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271310AbTHRHJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 03:09:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41194 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271311AbTHRHJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 03:09:02 -0400
Date: Mon, 18 Aug 2003 00:01:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818000139.6964cd04.davem@redhat.com>
In-Reply-To: <20030818065652.GA15098@alpha.home.local>
References: <200308171516090038.0043F977@192.168.128.16>
	<1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	<200308171555280781.0067FB36@192.168.128.16>
	<1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	<200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817222258.257694b9.davem@redhat.com>
	<20030818065652.GA15098@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 08:56:52 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> But I'm willing to try arpfilter if you show me where to start from.

There are tools at:

	http://ebtables.sourceforge.net/
