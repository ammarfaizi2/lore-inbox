Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbTCWL34>; Sun, 23 Mar 2003 06:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263030AbTCWL34>; Sun, 23 Mar 2003 06:29:56 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:31212 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263027AbTCWL3z>;
	Sun, 23 Mar 2003 06:29:55 -0500
Date: Sun, 23 Mar 2003 12:58:27 +0100
From: Antonio Vargas <wind@cocodriloo.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: configuring kernel-2.5.6x
Message-ID: <20030323115827.GA508@wind.cocodriloo.com>
References: <1048394971.30382.8.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048394971.30382.8.camel@tiger>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 11:49:31PM -0500, Louis Garcia wrote:
> How can I feed make oldconfig a config file? I'm trying to build an rpm
> with a custom kernel setup for my hardware. I already made a config file
> with make menuconfig. If this is the wrong way to do it please let me
> know. Oh, I don't mean the make rpm way, I'm making my own spec file.
> 
> Thanks

Just place your old config file as .config at the root of the
kernel tree, then "make oldconfig" will put it up.

Greets, Antonio.

