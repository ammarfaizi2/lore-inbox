Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSLICgz>; Sun, 8 Dec 2002 21:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSLICgz>; Sun, 8 Dec 2002 21:36:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3081 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262067AbSLICgy>;
	Sun, 8 Dec 2002 21:36:54 -0500
Date: Sun, 8 Dec 2002 18:43:45 -0800
From: Greg KH <greg@kroah.com>
To: Khalid Aziz Khalid Shuah Khan <khalid@gonehiking.org>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] Add support for Epson 785EPX Storage device
Message-ID: <20021209024345.GB27730@kroah.com>
References: <20021208214329.F0F70374C1@waltz.gonehiking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021208214329.F0F70374C1@waltz.gonehiking.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 02:43:29PM -0700, Khalid Aziz Khalid Shuah Khan wrote:
> Epson 785EPX USB printer has a PCMCIA slot that works as a USB storage
> device. usb-storage driver fails to recognize this device since it
> returns 0xff for Subclass. Attached patch adds support for the PCMCIA
> slot to usb-storage driver.
> 
> Marcelo, please apply.

Please send this to the usb-storage author and maintainer.

thanks,

greg k-h
