Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268540AbSIRVZ4>; Wed, 18 Sep 2002 17:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268544AbSIRVZ4>; Wed, 18 Sep 2002 17:25:56 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:65031 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268540AbSIRVZz>;
	Wed, 18 Sep 2002 17:25:55 -0400
Date: Wed, 18 Sep 2002 14:30:59 -0700
From: Greg KH <greg@kroah.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support
Message-ID: <20020918213058.GH10970@kroah.com>
References: <180577A42806D61189D30008C7E632E8793A6A@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A6A@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 05:09:50PM -0400, Bloch, Jack wrote:
> Our HW uses an AMCC S5935 PCI controller. Right now, since we own both
> device and SW, we are using a simple interrupt mechanism to accomplish the
> hot swap. 

What do you mean "simple interrupt mechanism"?  How does the OS know
that a PCI card has disappeared or show up?

thanks,

greg k-h
