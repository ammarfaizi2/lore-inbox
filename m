Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbSIYPlM>; Wed, 25 Sep 2002 11:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262010AbSIYPlL>; Wed, 25 Sep 2002 11:41:11 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:30472 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262009AbSIYPlK>;
	Wed, 25 Sep 2002 11:41:10 -0400
Date: Wed, 25 Sep 2002 08:45:11 -0700
From: Greg KH <greg@kroah.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.5.38uc1 (MMU-less support)
Message-ID: <20020925154511.GG30339@kroah.com>
References: <3D913223.6060801@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D913223.6060801@snapgear.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver patches look good, and I didn't see anything wrong with the
exception of what Matthew already said.

But I did have a small question about the font:

> . Motorola 68328 framebuffer
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc1-fb.patch.gz

The % and & characters are the same.  Is this intentional?

thanks,

greg k-h
