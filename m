Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTAOHQJ>; Wed, 15 Jan 2003 02:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTAOHQJ>; Wed, 15 Jan 2003 02:16:09 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14346 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262038AbTAOHQI>;
	Wed, 15 Jan 2003 02:16:08 -0500
Date: Tue, 14 Jan 2003 23:24:45 -0800
From: Greg KH <greg@kroah.com>
To: Richard Bouska <Richard@Bouska.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB: Sony clie does not word with recent 2.5
Message-ID: <20030115072444.GA20302@kroah.com>
References: <200301150735.41914.Richard@Bouska.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301150735.41914.Richard@Bouska.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 07:35:41AM +0100, Richard Bouska wrote:
> Hello,
> 
> I am not able to sync the Clie SL10 with the recent 2.5 kernels - with 2.4 
> everything works.
> The visor and usbserial are modules, but I dont think it changes anythink.
> 
> syslog of 2.5.58:

Can you see if 2.5.57 works for you?  I made some changes to the visor
driver in 2.5.58, that I was not able to check out on a Palm OS 4.0
device, as I do not have one (it works for older Handspring devices).

thanks,

greg k-h
