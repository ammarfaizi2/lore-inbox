Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSH1Fm6>; Wed, 28 Aug 2002 01:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318722AbSH1Fm6>; Wed, 28 Aug 2002 01:42:58 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:48908 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318721AbSH1Fm6>;
	Wed, 28 Aug 2002 01:42:58 -0400
Date: Tue, 27 Aug 2002 22:46:47 -0700
From: Greg KH <greg@kroah.com>
To: Nicholas Miell <nmiell@attbi.com>
Cc: linux-kernel@vger.kernel.org, johannes@erdfelt.com, mochel@osdl.org
Subject: Re: OOPS: USB and/or devicefs
Message-ID: <20020828054647.GA26390@kroah.com>
References: <1030270093.1531.8.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030270093.1531.8.camel@entropy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 03:08:12AM -0700, Nicholas Miell wrote:
> I'm not sure what caused this exactly -- I unplugged a USB hub and then
> did a ls in the hub's directory in the devicefs. The ls died (in D
> state), and I found this in my logs.

Does this still happen on 2.5.32?  I was unable to reproduce it on
either 2.5.31, 2.5.31-bk, or 2.5.32.

thanks,

greg k-h
