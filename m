Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRKMQud>; Tue, 13 Nov 2001 11:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276707AbRKMQu0>; Tue, 13 Nov 2001 11:50:26 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:10001 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276477AbRKMQsw>;
	Tue, 13 Nov 2001 11:48:52 -0500
Date: Tue, 13 Nov 2001 09:47:52 -0800
From: Greg KH <greg@kroah.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.4.14 in USB? Appletalk?
Message-ID: <20011113094752.D31479@kroah.com>
In-Reply-To: <1005626975.3296.2.camel@gromit.house>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005626975.3296.2.camel@gromit.house>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 16 Oct 2001 16:19:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 11:49:34PM -0500, Michael Rothwell wrote:
> This oops is from booting a RH 7.2 system after installing 2.4.14 +
> ext3.

Can you try 2.4.15-pre4?  This problem should be fixed in that version.

thanks,

greg k-h
