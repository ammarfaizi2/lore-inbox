Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310349AbSCBIGB>; Sat, 2 Mar 2002 03:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310352AbSCBIFv>; Sat, 2 Mar 2002 03:05:51 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:29715 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310349AbSCBIFs>;
	Sat, 2 Mar 2002 03:05:48 -0500
Date: Fri, 1 Mar 2002 23:58:47 -0800
From: Greg KH <greg@kroah.com>
To: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
Message-ID: <20020302075847.GE20536@kroah.com>
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 02 Feb 2002 05:03:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 03:57:31PM -0600, Sandino Araico Sánchez wrote:
> The Oops happens after I use the ide-scsi module with my CDRW and then I
> plug the Zip USB in.

Can you run the oops through ksymoops and send it to us?

thanks,

greg k-h
