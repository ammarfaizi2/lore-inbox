Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316444AbSFEUoK>; Wed, 5 Jun 2002 16:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSFEUoJ>; Wed, 5 Jun 2002 16:44:09 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:50955 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316444AbSFEUoH>;
	Wed, 5 Jun 2002 16:44:07 -0400
Date: Wed, 5 Jun 2002 13:41:23 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem with new driver model?
Message-ID: <20020605204123.GG4339@kroah.com>
In-Reply-To: <1023308709.791.8.camel@diemos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 08 May 2002 18:32:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 03:25:08PM -0500, Paul Fulghum wrote:
> When testing the drivers I maintain on 2.5.20, I hit the
> BUG_ON in include/linux/devices.txt:115.

See:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=102316813812289&w=2

for a fix for this problem.

thanks,

greg k-h
