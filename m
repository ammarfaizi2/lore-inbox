Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbRLaXW1>; Mon, 31 Dec 2001 18:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287680AbRLaXWR>; Mon, 31 Dec 2001 18:22:17 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:14089 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287684AbRLaXWI>;
	Mon, 31 Dec 2001 18:22:08 -0500
Date: Mon, 31 Dec 2001 15:21:28 -0800
From: Greg KH <greg@kroah.com>
To: Jimmie Mayfield <mayfield@sackheads.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Datafab and Lexar Jumpshot USB driver updates
Message-ID: <20011231152128.C21471@kroah.com>
In-Reply-To: <20011228094942.A10068@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228094942.A10068@sackheads.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 03 Dec 2001 20:56:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 09:49:42AM -0800, Jimmie Mayfield wrote:
> 
> Changes against 2.4.17:
>   - Updates to Configure.help for these 2 drivers
>   - I re-added the "EXPERIMENTAL" tag for these 2 drivers due to their nature
>   - Added an entry for a109-based readers
>   - Now handles media change events (thanks Joerg Schneider)

Have you sent this patch to the usb-storage maintainer?

thanks,

greg k-h
