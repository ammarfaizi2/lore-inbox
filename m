Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSGXNiP>; Wed, 24 Jul 2002 09:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSGXNiO>; Wed, 24 Jul 2002 09:38:14 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:23133 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317214AbSGXNiN>; Wed, 24 Jul 2002 09:38:13 -0400
Date: Wed, 24 Jul 2002 16:40:52 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Nico Schottelius <nicos-mutt@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.27 floppy driver
Message-ID: <20020724134052.GM1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Nico Schottelius <nicos-mutt@pcsystems.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020724134026.GB479@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724134026.GB479@schottelius.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 03:40:26PM +0200, you [Nico Schottelius] wrote:
> Sorry to disturb again:
> The floppy driver is broken in this kernel, too.
> Reading/writing lets the accessing program just 'hang around'.
> 
> Luckily the floppy driver is happy and reports its problems to us.

Seems the same I got with 2.5.26:

http://groups.google.com/groups?ie=UTF-8&oe=utf-8&as_umsgid=20020722075313.GN1465@niksula.cs.hut.fi&lr=&num=50&hl=en


-- v --

v@iki.fi
