Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSAUQzc>; Mon, 21 Jan 2002 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSAUQzW>; Mon, 21 Jan 2002 11:55:22 -0500
Received: from ms25.windstoneinc.com ([206.222.212.217]:15339 "EHLO
	unpythonic.dhs.org") by vger.kernel.org with ESMTP
	id <S287436AbSAUQzC>; Mon, 21 Jan 2002 11:55:02 -0500
Date: Mon, 21 Jan 2002 10:58:17 -0600
From: jepler@unpythonic.dhs.org
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020121105817.B1520@unpythonic.dhs.org>
Mail-Followup-To: jepler@unpythonic.dhs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com> <3C4C1C96.9330C916@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C4C1C96.9330C916@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 01:50:14PM +0000, Arjan van de Ven wrote:
> "David S. Miller" wrote:
> 
> > The funny part is, if this published errata is the problem, it cannot
> > be a problem under Linux since we never invalidate 4MB pages.  We
> > create them at boot time and they never change after that.
> 
> Well we don't know what nvidia's kernel module is doing.....

.. which makes it not a kernel bug, right?  Just some buggy module that
bangs hardware in a way documented to not work...

Jeff
