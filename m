Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSFJT71>; Mon, 10 Jun 2002 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFJT70>; Mon, 10 Jun 2002 15:59:26 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:50439 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315942AbSFJT7Z>;
	Mon, 10 Jun 2002 15:59:25 -0400
Date: Mon, 10 Jun 2002 12:55:46 -0700
From: Greg KH <greg@kroah.com>
To: Andre Bonin <kernel@bonin.ca>
Cc: Roberto Nibali <ratz@drugphish.ch>, root@chaos.analogic.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
Message-ID: <20020610195545.GA3508@kroah.com>
In-Reply-To: <Pine.LNX.3.95.1020610141042.17451B-100000@chaos.analogic.com> <3D04EDC1.8010402@drugphish.ch> <3D04F704.5090202@bonin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 13 May 2002 18:01:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 02:59:16PM -0400, Andre Bonin wrote:
> 
> Does the SCSI layer via sbp2 provide functionality for USB 2.0 (EHCI) 
> disks?

Yes, but it's supported by the usb-storage driver, not the ieee1394
driver :)

greg k-h
