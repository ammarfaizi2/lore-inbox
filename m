Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUKDQPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUKDQPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUKDQPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:15:23 -0500
Received: from ns1.digitalpath.net ([65.164.104.5]:45465 "HELO
	mail.digitalpath.net") by vger.kernel.org with SMTP id S262274AbUKDQPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:15:19 -0500
Date: Thu, 4 Nov 2004 08:14:30 -0800
From: Ray Van Dolson <rayvd@digitalpath.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/prio_tree.c:377
Message-ID: <20041104161430.GA11607@digitalpath.net>
References: <20041104003639.GA9671@digitalpath.net> <1099555455.16640.1.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099555455.16640.1.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppp_mppe patch from the pppd package.  Lots of people use it without
problems.  If it is the source of troubles, that won't be good as we need
it for our clients to connect. :)

On Thu, Nov 04, 2004 at 09:04:16AM +0100, Arjan van de Ven wrote:
> On Wed, 2004-11-03 at 16:36 -0800, Ray Van Dolson wrote:
> > Description of problem:
> > Running on an HP DL140, w/ Dual 2.4GHz Xeon's. 1GB of ECC DDR. Fedora
> > Core 2.
> > EIP: 0060:[<021425de>] Tainted: P
> Which binary only driver are you using ?
