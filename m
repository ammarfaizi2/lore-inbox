Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUAOW6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUAOW5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:57:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38162 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263777AbUAOW4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:56:43 -0500
Date: Thu, 15 Jan 2004 23:56:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Tolfsen <ato@online.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: True story: "gconfig" removed root folder...
In-Reply-To: <40070D64.6090307@online.no>
Message-ID: <Pine.LNX.4.58.0401152354160.27223@serv>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv>
 <20040115212304.GA25296@rlievin.dyndns.org> <Pine.LNX.4.58.0401152245030.27223@serv>
 <40070D64.6090307@online.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, Andreas Tolfsen wrote:

> > What do you mean with "destroyed"? All I can reproduce here is that it's
> > simply moved away, but it's still there!
>
> Is it supposed to be moved away?  I'm just being curious...

Yes, this usually produces ".config.old", but there is nowhere a "rm -Rf"
as the initial mail suggests.

bye, Roman
