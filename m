Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313791AbSDIAGc>; Mon, 8 Apr 2002 20:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313799AbSDIAGb>; Mon, 8 Apr 2002 20:06:31 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:36100 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313791AbSDIAGa>;
	Mon, 8 Apr 2002 20:06:30 -0400
Date: Mon, 8 Apr 2002 17:04:13 -0700
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre6 dead Makefile entries
Message-ID: <20020409000413.GE10263@kroah.com>
In-Reply-To: <27694.1018177299@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 11 Mar 2002 21:17:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 09:01:39PM +1000, Keith Owens wrote:
> 
> drivers/usb/storage/Makefile    shuttle_sm.o
>                                 shuttle_cf.o

I've just removed these rules from my 2.5 and 2.4 trees, and will send
the changes on upstream with the next round of USB patches.

thanks,

greg k-h
