Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbTCSBI0>; Tue, 18 Mar 2003 20:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbTCSBI0>; Tue, 18 Mar 2003 20:08:26 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30216 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262875AbTCSBIZ>;
	Tue, 18 Mar 2003 20:08:25 -0500
Date: Tue, 18 Mar 2003 17:07:16 -0800
From: Greg KH <greg@kroah.com>
To: Trammell Hudson <hudson@osresearch.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs fails for medium sized cpio archives
Message-ID: <20030319010716.GI10089@kroah.com>
References: <20030319011116.GK8263@osbox.osresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319011116.GK8263@osbox.osresearch.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 06:11:17PM -0700, Trammell Hudson wrote:
> [ Please cc me on any replies.  Thanks! ]
> 
> I'm trying to get 2.5.64 to load my initramfs cpio archive and
> have run into a problem with memory allocation during the
> unpacking.

This should be fixed in 2.5.65.  Please let us know if you still have
problems after trying that kernel.

thanks,

greg k-h
