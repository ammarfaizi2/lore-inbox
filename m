Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314523AbSDSCiA>; Thu, 18 Apr 2002 22:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSDSCgX>; Thu, 18 Apr 2002 22:36:23 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:14597 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314520AbSDSCfS>;
	Thu, 18 Apr 2002 22:35:18 -0400
Date: Thu, 18 Apr 2002 18:34:09 -0700
From: Greg KH <greg@kroah.com>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG in ext3 (2.4.18pre1)
Message-ID: <20020419013409.GB9079@kroah.com>
In-Reply-To: <5.1.0.14.0.20020418230637.0164d828@mailhost.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 21 Mar 2002 23:25:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 11:13:52PM +0100, Ruth Ivimey-Cook wrote:
> 
> System: Cyrix i586/333 with 32MB RAM, ALi Mobo. OS: RH7.2/server with 
> kernel.org 2.4.18pre1 kernel + Speedtouch USB patches.

I'd go complain to the speedtouch people, as their driver has some known
problems.

Good luck,

greg k-h
