Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbTC1AaP>; Thu, 27 Mar 2003 19:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTC1AaP>; Thu, 27 Mar 2003 19:30:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57097 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261691AbTC1AaP>;
	Thu, 27 Mar 2003 19:30:15 -0500
Date: Thu, 27 Mar 2003 16:40:24 -0800
From: Greg KH <greg@kroah.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: config options for PS/2 kbd and USB mouse?
Message-ID: <20030328004024.GE3416@kroah.com>
References: <Pine.LNX.4.44.0303271841350.1387-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303271841350.1387-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 06:47:29PM -0500, Robert P. J. Day wrote:
> 
> are there new options i should be looking at to support a
> PS/2 keyboard on this laptop?  i've selected pretty much all
> of the options i thought i needed, but no results so far.

Did you enable CONFIG_SERIO_I8042 ?

greg k-h
