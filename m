Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbTCTWad>; Thu, 20 Mar 2003 17:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262740AbTCTW3U>; Thu, 20 Mar 2003 17:29:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:46597 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262695AbTCTW2x>;
	Thu, 20 Mar 2003 17:28:53 -0500
Date: Thu, 20 Mar 2003 14:40:08 -0800
From: Greg KH <greg@kroah.com>
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Ignore P5 Data Glove (2.4 and 2.5 patches)
Message-ID: <20030320224008.GA5156@kroah.com>
References: <20030320195305.GA3370@client100.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320195305.GA3370@client100.evillabs.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 02:53:05PM -0500, Jason McMullan wrote:
> 
>   As requested, here are the 2.4 (latest BK tree) and 2.5 (latest bk
>   tree) patches to ignore the non-HID Essential Reality Data Glove

Thanks, I've applied these to my 2.4 and 2.5 trees, and will send them
onward soon.

greg k-h
