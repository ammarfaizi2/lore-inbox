Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293530AbSCOXn6>; Fri, 15 Mar 2002 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293527AbSCOXns>; Fri, 15 Mar 2002 18:43:48 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:1798 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293521AbSCOXnd>;
	Fri, 15 Mar 2002 18:43:33 -0500
Date: Fri, 15 Mar 2002 15:43:33 -0800
From: Greg KH <greg@kroah.com>
To: Gordon J Lee <gordonl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020315234333.GH5563@kroah.com>
In-Reply-To: <3C927F3E.7C7FB075@world.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C927F3E.7C7FB075@world.std.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 15 Feb 2002 19:01:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 06:09:50PM -0500, Gordon J Lee wrote:
> 2.4.9     works fine!

Forgot to mention, how many processors does this kernel show you having?
I think you need to run the latest 2.4.19-ac kernel to get the second
processors to show up properly.

thanks,

greg k-h
