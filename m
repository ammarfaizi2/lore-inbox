Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbSJNAVp>; Sun, 13 Oct 2002 20:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbSJNAVp>; Sun, 13 Oct 2002 20:21:45 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18948 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261772AbSJNAVo>;
	Sun, 13 Oct 2002 20:21:44 -0400
Date: Sun, 13 Oct 2002 17:28:01 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, johannes@erdfelt.com
Subject: Re: [2.5.42][USB] Sleeping in illegal context
Message-ID: <20021014002800.GB1062@kroah.com>
References: <20021013121807.GA527@dreamland.darkstar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013121807.GA527@dreamland.darkstar.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 02:18:07PM +0200, Kronos wrote:
> 
> I get the following debug messages during boot, at USB initialization:

Fixed in the set of patches I just sent to Linus.

thanks,

greg k-h
