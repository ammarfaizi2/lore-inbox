Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTBUOkq>; Fri, 21 Feb 2003 09:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTBUOkp>; Fri, 21 Feb 2003 09:40:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:42759 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267458AbTBUOkp>;
	Fri, 21 Feb 2003 09:40:45 -0500
Date: Fri, 21 Feb 2003 06:43:34 -0800
From: Greg KH <greg@kroah.com>
To: Andree Leidenfrost <aleidenf@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: Palm Tungsten T + kernel 2.4.20 + Tungsten patch applied
Message-ID: <20030221144334.GB29793@kroah.com>
References: <1045824312.1404.37.camel@aurich.ostfriesland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045824312.1404.37.camel@aurich.ostfriesland>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 09:45:12PM +1100, Andree Leidenfrost wrote:
> Syncing my m505 works fine, but I'd love to be able to sync my new and
> shiny Tungsten T... ;-)

Try using /dev/ttyUSB0 instead of /dev/ttyUSB1, some people have
reported that this is necessary.  If this doesn't work, the pilot-link
mailing list should be able to help you out.

Good luck,

greg k-h
