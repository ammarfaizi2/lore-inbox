Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSBXQUl>; Sun, 24 Feb 2002 11:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSBXQUb>; Sun, 24 Feb 2002 11:20:31 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:28165 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289815AbSBXQUT>;
	Sun, 24 Feb 2002 11:20:19 -0500
Date: Sun, 24 Feb 2002 08:14:20 -0800
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE clean 12 3rd attempt
Message-ID: <20020224161420.GA22498@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <3C78DC80.8080402@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C78DC80.8080402@evision-ventures.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 27 Jan 2002 13:57:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:28:48PM +0100, Martin Dalecki wrote:
> This patch does the following:
> 
> 1. Add some notes to Documentation/driver-model.txt about how and
>    and where to mount the driverfs.

This portion of the patch should be split out and submitted separately,
to the author of the document, as it doesn't really have anything to do
with the rest of the ide changes.

thanks,

greg k-h
