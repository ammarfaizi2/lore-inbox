Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRB0CIk>; Mon, 26 Feb 2001 21:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRB0CIb>; Mon, 26 Feb 2001 21:08:31 -0500
Received: from saw.swusa.com ([207.214.125.61]:42137 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129453AbRB0CIT>;
	Mon, 26 Feb 2001 21:08:19 -0500
Message-ID: <20010226180927.A32604@saw.sw.com.sg>
Date: Mon, 26 Feb 2001 18:09:27 -0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: angelcode <angelcode@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: weird eepro100 msgs
In-Reply-To: <983085249.280angelcode@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <983085249.280angelcode@myrealbox.com>; from "angelcode" on Sun, Feb 25, 2001 at 07:14:09AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 07:14:09AM +0000, angelcode wrote:
> I've been seeing the same kind of messages with an eepro100 
> but they don't happen when the module is loaded.  They 
> happen after it has been running for a few days.  I am 
> running 2.4.1.  I haven't seen any real problems but these 
> messages still scare me.  

If your network isn't stuck, it's not a real problem.
The card just reports that it feels shortage of receive buffers.
It may be real or illusional one, it's not a really big problem.

Best regards
		Andrey

> > > > On Fri, 2 Feb 2001 15:01:05 -0800 (PST), Ivan Passos 
> <lists@cyclades.com> wrote:
> > > > > eth0: card reports no resources.
> > > > > eth0: card reports no RX buffers.
> > > > > eth0: card reports no resources.
> > > > > eth0: card reports no RX buffers.
> > > > > eth0: card reports no resources.
> > > > > eth0: card reports no RX buffers.
> > > > > (...)
