Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSDOQYr>; Mon, 15 Apr 2002 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312943AbSDOQYq>; Mon, 15 Apr 2002 12:24:46 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:36108 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312939AbSDOQYp>;
	Mon, 15 Apr 2002 12:24:45 -0400
Date: Mon, 15 Apr 2002 08:24:12 -0700
From: Greg KH <greg@kroah.com>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 OOPS usb-uhci
Message-ID: <20020415152412.GI21356@kroah.com>
In-Reply-To: <3CBABB92.8000307@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 18 Mar 2002 12:46:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 01:37:54PM +0200, Pierre Rousselet wrote:
> PIII 650 UP. kernel tainted by speedtch.o (usb Speedtouch Alcatel driver).

Bleah, please send any problems with this driver to the authors of the
driver, as I have no idea of what that driver does (or even if it has
been properly converted to the 2.5 USB api changes.)

thanks,

greg k-h
