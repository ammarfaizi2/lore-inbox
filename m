Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUFORss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUFORss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUFORsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:48:46 -0400
Received: from holomorphy.com ([207.189.100.168]:20136 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265808AbUFORs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:48:28 -0400
Date: Tue, 15 Jun 2004 10:35:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [3/12] remove irda usage of isa_virt_to_bus()
Message-ID: <20040615173543.GB1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040615014344.GA17657@bougret.hpl.hp.com> <20040615091219.GR1444@holomorphy.com> <20040615170158.GE11105@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615170158.GE11105@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:12:19AM -0700, William Lee Irwin III wrote:
>> OTOH, it was easier to find than buried in
>> a distro BTS and/or cvs, not that that makes it ideal.

On Tue, Jun 15, 2004 at 10:01:58AM -0700, Jean Tourrilhes wrote:
> 	Debian is usually very good sending me bug reports (especiall
> on wireless tools), so I'm a bit surprised that it did not work this
> time. But I've seen a recent trend by Debian to do more Debian
> specific stuff for system level config, which I find disturbing.

These seem to be the ones that have leaked through the cracks. Apart
from this (and the posting is helping to find all the concerned parties)
things should go largely through normal channels in general.

Also, thanks for doing the footwork to get this thing properly
evaluated, as it was unclear to me the risks involved. I don't want
bogus code going in.


-- wli
