Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290537AbSAYENF>; Thu, 24 Jan 2002 23:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290541AbSAYEMz>; Thu, 24 Jan 2002 23:12:55 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:61703 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290537AbSAYEMl>;
	Thu, 24 Jan 2002 23:12:41 -0500
Date: Thu, 24 Jan 2002 20:12:26 -0800
From: Greg KH <greg@kroah.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb or video4linux problem
Message-ID: <20020125041226.GA22366@kroah.com>
In-Reply-To: <20020125032857.GA671@online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020125032857.GA671@online.fr>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 28 Dec 2001 02:10:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 10:28:57PM -0500, christophe barbé wrote:
> 
> I'm convinced that it's a problem with OHCI.
> I think it's a soft problem because I can trigger it with cpu/io
> activity.

Does the kernel log show any USB errors, or any USB messages at all?
What kernel version are you using?

thanks,

greg k-h
