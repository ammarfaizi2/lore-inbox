Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312834AbSDOFWT>; Mon, 15 Apr 2002 01:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312859AbSDOFWS>; Mon, 15 Apr 2002 01:22:18 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:30219 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312834AbSDOFWR>;
	Mon, 15 Apr 2002 01:22:17 -0400
Date: Sun, 14 Apr 2002 21:21:47 -0700
From: Greg KH <greg@kroah.com>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 croaks with USB and make dep
Message-ID: <20020415042147.GA18791@kroah.com>
In-Reply-To: <20020415024914.GA28512@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 17 Mar 2002 20:10:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 07:49:14PM -0700, A Guy Called Tyketto wrote:
> 
>         Subject sez it all:

Did you run 'make oldconfig' first?
How about 'make mrproper'?  You might have to clean out some old files
first, as the USB files all moved around.

thanks,

greg k-h
