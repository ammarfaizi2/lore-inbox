Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSAPRWG>; Wed, 16 Jan 2002 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbSAPRWB>; Wed, 16 Jan 2002 12:22:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:35857 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284264AbSAPRVW>;
	Wed, 16 Jan 2002 12:21:22 -0500
Date: Wed, 16 Jan 2002 09:17:45 -0800
From: Greg KH <greg@kroah.com>
To: Kim Yong Il <nalabi@formail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 ] Can't usb-storage
Message-ID: <20020116171744.GB1064@kroah.com>
In-Reply-To: <20020116102248.A29240@formail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116102248.A29240@formail.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 19 Dec 2001 15:13:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 10:22:48AM +0900, Kim Yong Il wrote:
> I can use  usb-storage in 2.4.16, 
> 
> But can't use in 2.4.17

Ah, descriptive bug reports, that are so easy to figure out what is going on :)

Please read REPORTING-BUGS in the kernel tree and also the steps to
report a USB bug on the linux-usb.org web page.

thanks,

greg k-h
