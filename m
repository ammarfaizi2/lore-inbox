Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264757AbSJUGwe>; Mon, 21 Oct 2002 02:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264758AbSJUGwe>; Mon, 21 Oct 2002 02:52:34 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:32147 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264757AbSJUGwd>;
	Mon, 21 Oct 2002 02:52:33 -0400
Date: Mon, 21 Oct 2002 08:58:39 +0200
From: bert hubert <ahu@ds9a.nl>
To: Latha B lingaiah <l_lingaiah@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP  DELAY
Message-ID: <20021021065839.GA6108@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Latha B lingaiah <l_lingaiah@yahoo.com>, linux-kernel@vger.kernel.org
References: <20021021065600.3738.qmail@web12806.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021065600.3738.qmail@web12806.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 11:56:00PM -0700, Latha B lingaiah wrote:
> Hi,
> 
> While transfering a 42MB file, there seem to be a TCP
> delay between the kernels 2.4.7 and 2.4.18.

Don't do such short measurements, 4.5 seconds is no way to do statistics.
TCP/IP does not start out at full speed but takes some time to find the
right speed.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
