Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUGGHvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUGGHvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUGGHvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:51:35 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:9143 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264961AbUGGHvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:51:33 -0400
Date: Wed, 7 Jul 2004 00:50:27 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>,
       Stephen Hemminger <shemminger@osdl.org>, ahu@ds9a.nl,
       acme@conectiva.com.br, netdev@oss.sgi.com, alessandro.suardi@oracle.com,
       phyprabab@yahoo.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040707075027.GC17205@taniwha.stupidest.org>
References: <20040629222751.392f0a82.davem@redhat.com> <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net> <20040630153049.3ca25b76.davem@redhat.com> <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <20040706132426.097f71e6.davem@redhat.com> <20040706231600.GA18181@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706231600.GA18181@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 01:16:00AM +0200, Andi Kleen wrote:

> [btw it's quite possible that this isn't a firewall, but also
> some kind of header compression that is doing the wrong thing]

... or some kind of nasty intrusive bandwidth molesting device like a
PacketShaper...


   --cw
