Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267416AbTAGQ7C>; Tue, 7 Jan 2003 11:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTAGQ7B>; Tue, 7 Jan 2003 11:59:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11784 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267416AbTAGQ7A>;
	Tue, 7 Jan 2003 11:59:00 -0500
Date: Tue, 7 Jan 2003 09:07:28 -0800
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: patmans@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-kernel@one-eyed-alien.net, zwane@holomorphy.com
Subject: Re: [linux-usb-devel] Re: IDs
Message-ID: <20030107170728.GA27521@kroah.com>
References: <20030106191522.A11624@beaverton.ibm.com> <UTC200301071055.h07At0T09202.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200301071055.h07At0T09202.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 11:55:00AM +0100, Andries.Brouwer@cwi.nl wrote:
> 
> The sysfs tree does not contain device nodes.

And that will remain true.

> Do you plan a user space utility that figures out that
> the ID "SHP      CD-Writer+ 8200 [" belongs to /dev/hdd
> which also is /dev/sr0?

Yes.  Well, at least I plan on creating such a utility once more of the
kernel is converted over to using sysfs :)

thanks,

greg k-h
