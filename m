Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSADVtm>; Fri, 4 Jan 2002 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbSADVtd>; Fri, 4 Jan 2002 16:49:33 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5892 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284987AbSADVtY>;
	Fri, 4 Jan 2002 16:49:24 -0500
Date: Fri, 4 Jan 2002 13:48:00 -0800
From: Greg KH <greg@kroah.com>
To: Alan <alan@clueserver.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB Storage Config patch for 2.4.17 and 2.5.1
Message-ID: <20020104214800.GC21034@kroah.com>
In-Reply-To: <200201041041.g04AfiL05830@clueserver.org> <20020104171758.GA17028@kroah.com> <200201042117.g04LHkL08977@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201042117.g04LHkL08977@clueserver.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 07 Dec 2001 19:03:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 10:47:57AM -0800, Alan wrote:
> 
> Here is the patch attached. Tested on 2.4.17 and 2.5.1. (Needs a version for 
> the new 2.5.x config structure, but that should be trivial.)

Thanks, I've applied just a portion of the patch (no need in indenting
the usb-storage options, see
http://linuxusb.bitkeeper.com:8088/usb-2.4/patch@1.563?nav=cset@1.563
and
http://linuxusb.bitkeeper.com:8088/usb-2.5/patch@1.135?nav=cset@1.135
for the end result) to my 2.4 and 2.5 trees.  I'll forward them on the
the proper kernel maintainers.

> BTW, this was written during the PLUG meeting last night. (Which you missed.) 

Ah, must have been another boring meeting if you were writing kernel
config patches during it :)

thanks,

greg k-h
