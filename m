Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSGHCnc>; Sun, 7 Jul 2002 22:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSGHCnb>; Sun, 7 Jul 2002 22:43:31 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:11023 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316750AbSGHCna>;
	Sun, 7 Jul 2002 22:43:30 -0400
Date: Sun, 7 Jul 2002 19:43:54 -0700
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from driverfs
Message-ID: <20020708024354.GA19452@kroah.com>
References: <Pine.LNX.4.33.0207051043120.8496-100000@geena.pdx.osdl.net> <3D28DF9E.20907@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D28DF9E.20907@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 10 Jun 2002 01:26:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 05:41:02PM -0700, Dave Hansen wrote:
> 
> I need to get some USB devices that work in Linux!

I can easily fix that :)

greg k-h
