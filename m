Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310344AbSCBHXK>; Sat, 2 Mar 2002 02:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310342AbSCBHW7>; Sat, 2 Mar 2002 02:22:59 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:23059 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310341AbSCBHWq>;
	Sat, 2 Mar 2002 02:22:46 -0500
Date: Fri, 1 Mar 2002 23:15:45 -0800
From: Greg KH <greg@kroah.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.19-pre1-ac1] usbnet frames mangled
Message-ID: <20020302071545.GB20536@kroah.com>
In-Reply-To: <1015003428.2274.5.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015003428.2274.5.camel@bip>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 02 Feb 2002 05:03:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 06:23:48PM +0100, Xavier Bestel wrote:
> 
> which of course doesn't mean anything. I saw this behavior since I
> upgraded my desktop from 2.4.18-ac2 to 2.4.19-pre1-ac1

So you kept your USB client at the same version, but your host changed
versions?  And 2.4.18-ac2 works, but 2.4.19-pre1-ac1 doesn't?

Can you see if 2.4.19-pre2 works or not for you?

And which USB host controller driver are you using?

thanks,

greg k-h
