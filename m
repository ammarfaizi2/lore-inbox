Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271473AbRIAXXw>; Sat, 1 Sep 2001 19:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271486AbRIAXXm>; Sat, 1 Sep 2001 19:23:42 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:33807 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271473AbRIAXXj>;
	Sat, 1 Sep 2001 19:23:39 -0400
Date: Sat, 1 Sep 2001 16:21:30 -0700
From: Greg KH <greg@kroah.com>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: USB trouble w/ 2.4.8-ac12
Message-ID: <20010901162130.C26407@kroah.com>
In-Reply-To: <3B916760.1000104@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B916760.1000104@lycosmail.com>; from ajschrotenboer@lycosmail.com on Sat, Sep 01, 2001 at 06:55:28PM -0400
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 06:55:28PM -0400, Adam Schrotenboer wrote:
> Using 2.4.8-ac12, USB modules, and a Philips CDRW400.
> 
> I was able to get it to see the CDRW drive once(and that took a minute 
> or three), but mostly it only sees the Freecom USB-IDE bridge.
> 
> How do I get the usb code to probe the ATAPI bridge for the devices 
> behind it??

You might try asking on the linux-usb-devel mailing list.  I don't know
how well the Freecom bridge device is currently supported in Linux.

greg k-h
