Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbTCYThQ>; Tue, 25 Mar 2003 14:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263283AbTCYThQ>; Tue, 25 Mar 2003 14:37:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29202 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263284AbTCYThO>;
	Tue, 25 Mar 2003 14:37:14 -0500
Date: Tue, 25 Mar 2003 11:47:44 -0800
From: Greg KH <greg@kroah.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: trivial@rustycorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Tweak to allow usb-midi to be built
Message-ID: <20030325194744.GJ16847@kroah.com>
References: <20030325032133.GD22181@vitelus.com> <20030325032857.GA11874@kroah.com> <20030325033904.GE22181@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325033904.GE22181@vitelus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 07:39:04PM -0800, Aaron Lehmann wrote:
> On Mon, Mar 24, 2003 at 07:28:57PM -0800, Greg KH wrote:
> > What kernel version is this?  And what makefile?  Can you send the diff
> > so that it can be applied with patch -p1?
> 
> This is a recent snapshot from Linus' tree. The patch applies to
> drivers/usb/Makefile (sorry).

Ick, your email client ate all of the tabs in this file.  Can you try
sending it again after changing the settings somewhere?

thanks,

greg k-h
