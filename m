Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTAHQrK>; Wed, 8 Jan 2003 11:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTAHQrK>; Wed, 8 Jan 2003 11:47:10 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:17679 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S267374AbTAHQrJ>; Wed, 8 Jan 2003 11:47:09 -0500
Date: Thu, 9 Jan 2003 03:55:17 +1100
From: john slee <indigoid@higherplane.net>
To: John Bradford <john@grabjohn.com>
Cc: jeff-lk@gerard.st, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] menuconfig color sanity
Message-ID: <20030108165517.GG18508@higherplane.net>
References: <20030108155623.GA26882@kanoe.ludicrus.net> <200301081609.h08G929Q001835@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301081609.h08G929Q001835@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 04:09:02PM +0000, John Bradford wrote:
> > using yellow and green text with a "white" background in
> > menuconfig works all right on console
> 
> I have seen the original problem, where the first letter is not
> visible in an xterm.
> 
> Just add a colour/monochrome toggle, that way people can choose which
> they prefer.

'export TERM=xterm-mono' works fine here

j.

-- 
toyota power: http://indigoid.net/
