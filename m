Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSKRW7N>; Mon, 18 Nov 2002 17:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbSKRW7M>; Mon, 18 Nov 2002 17:59:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13327 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264724AbSKRW7M>;
	Mon, 18 Nov 2002 17:59:12 -0500
Date: Mon, 18 Nov 2002 14:59:53 -0800
From: Greg KH <greg@kroah.com>
To: Erik Lotspeich <erikvcl@silcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Crash in audio.o (USB Audio)
Message-ID: <20021118225952.GA13721@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0211181354540.13410-100000@goby.lotspeich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211181354540.13410-100000@goby.lotspeich.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 01:59:40PM -0800, Erik Lotspeich wrote:
> Hi,
> 
> I tried getting USB audio to work with Apple's USB speakers on Linux
> 2.4.17.  When I tried to access the audio device, the USB module would
> crash.  The USB system appears to properly identify the speakers and their
> capabilities.

Please try 2.4.19 and let us know if that fixes the problem or not.  If
not, a oops message, run through ksymoops would be very helpful.

thanks,

greg k-h
