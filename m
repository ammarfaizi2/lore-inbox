Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSF2OS1>; Sat, 29 Jun 2002 10:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSF2OS0>; Sat, 29 Jun 2002 10:18:26 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:56330 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S311025AbSF2OS0>;
	Sat, 29 Jun 2002 10:18:26 -0400
Date: Sat, 29 Jun 2002 07:20:10 -0700
From: Greg KH <greg@kroah.com>
To: Carsten Rietzschel <cr@daRav.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-xx USB-HID Bug ?!?
Message-ID: <20020629142010.GB18824@kroah.com>
References: <1025284549.5376.10.camel@linux.daR.av>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025284549.5376.10.camel@linux.daR.av>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 01 Jun 2002 12:31:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2002 at 07:15:47PM +0200, Carsten Rietzschel wrote:
> # CONFIG_USB_HIDINPUT is not set

You need to enable this option.  Please read the Configure.help entry
for why this is needed.

greg k-h
