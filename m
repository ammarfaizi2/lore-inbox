Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTIJKl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTIJKl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:41:59 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28564 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261903AbTIJKl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:41:58 -0400
Date: Wed, 10 Sep 2003 12:41:51 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Luca Veraldi <luca.veraldi@katamail.com>, alexander.riesen@synopsys.COM,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910124151.C9878@devserv.devel.redhat.com>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com> <20030910103752.GC21313@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910103752.GC21313@mail.jlokier.co.uk>; from jamie@shareable.org on Wed, Sep 10, 2003 at 11:37:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:37:52AM +0100, Jamie Lokier wrote:
> I thought that later generation CPUs were supposed to have lower
> memory bandwidth relative to the CPU core

this is far more true for "random/access" latency than for streaming bandwidth.
Memory is sort of starting to be like disk IO in this regard. 
