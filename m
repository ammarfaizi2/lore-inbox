Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVFTP51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFTP51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFTP51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:57:27 -0400
Received: from styx.suse.cz ([82.119.242.94]:30140 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261363AbVFTP5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:57:22 -0400
Date: Mon, 20 Jun 2005 17:57:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050620155720.GA22535@ucw.cz>
References: <004e01c575ab$43945860$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004e01c575ab$43945860$600cc60a@amer.sykes.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 09:18:08AM -0600, Alejandro Bonilla wrote:
> Hi,
> 
> 	As I have asked before, I will do it again. Sorry if this is not the right
> place.
> 
> I'm looking for someone, a hope, anything from anyone that have an IBM T40,
> T41, T42 or whoever has the Embedded "Airbag" solution in their Linux
> Laptops.
> 
> The Hard Drive Active Protection System, which is in the IBM laptops (and
> maybe some others) uses an Analog ADXL320 (or ADXL202) with the
> accelerometer for XY to monitor the movement in the laptops.
> 
> We have the Datasheet, Application notes and free "Tech support" from Analog
> Devices. Now, we need some developers interested in getting this to work. We
> just need someone to start something or to take a couple of minutes to see
> if this is doable, and if a linux driver came be made to make it work.
> 
> (There is also a Fingerprint reader that I would like to get working, but
> that is somehow screwed up by security layers) :)
> 
> PLEASE, if you have a couple of minutes, or if you are interested in getting
> this working, Please let me/us know.
> 
> http://www.analog.com/en/prod/0,2877,ADXL320,00.html
> 
> http://www.analog.com/en/prodRes/0,2889,ADXL202%255F871,00.html

I already have the documentation for the chips for my robotics projects,
I even have the chips. I'll have an Airbag-equipped IBM notebook soon,
hopefully, too.

However, this is not enough at all to write the driver. The
accelerometer is a trivial analog component (ok, not so trivial, but
still just analog), and the main question is how it is connected to the
PC.

Until IBM says something about that, or somebody reverse engineers their
BIOS/Windows drivers/whatever, a driver can't be written.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
