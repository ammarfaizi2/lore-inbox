Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbTCXXs3>; Mon, 24 Mar 2003 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCXXs3>; Mon, 24 Mar 2003 18:48:29 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:38281 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S261223AbTCXXs2>; Mon, 24 Mar 2003 18:48:28 -0500
Date: Mon, 24 Mar 2003 18:25:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Larry McVoy <lm@work.bitmover.com>, Steven Pritchard <steve@silug.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 3ware driver errors
Message-ID: <20030324182508.A15039@vger.timpanogas.org>
References: <20030324212813.GA6310@osiris.silug.org> <20030324180107.A14746@vger.timpanogas.org> <20030324234410.GB10520@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030324234410.GB10520@work.bitmover.com>; from lm@bitmover.com on Mon, Mar 24, 2003 at 03:44:10PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The person at WD to contact with specifics is listed below.  We have seen it 
on the 180GB drives, but the 200GB are also affected.

Suresh.Chekuri@wdc.com

Jeff

On Mon, Mar 24, 2003 at 03:44:10PM -0800, Larry McVoy wrote:
> On Mon, Mar 24, 2003 at 06:01:07PM -0700, Jeff V. Merkey wrote:
> > There is a firmware upgrade you need to obtain from WD if you are using their 
> > drives with a 3Ware controller.  The WD drives were optimized for desktop use
> > and they go into a "powersave" mode of sorts which will cause them to disappear
> > and reappear mysteriously with all sorts of strange errors.  WD is aware of 
> > this problem and so is 3Ware.
> 
> Is this for all WD drives or just some?  I've got some wd400 drives that 
> I've been using for a long time behind a 3ware in jbod mode.  I have seen
> some errors but they seem to have settled down.  Is there any way to know?
> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
