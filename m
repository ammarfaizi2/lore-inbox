Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVKITU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVKITU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVKITU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:20:59 -0500
Received: from hera.kernel.org ([140.211.167.34]:13469 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030343AbVKITU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:20:58 -0500
Date: Wed, 9 Nov 2005 12:15:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Willy TARREAU <willy@w.ods.org>
Subject: Re: Linux 2.4.32-rc3
Message-ID: <20051109141530.GA9332@logos.cnet>
References: <20051109133216.GA9183@logos.cnet> <20051109185223.GA4047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109185223.GA4047@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 07:52:23PM +0100, Adrian Bunk wrote:
> On Wed, Nov 09, 2005 at 11:32:16AM -0200, Marcelo Tosatti wrote:
> 
> > Hi,
> 
> Hi Marcelo,
> 
> > Two small issues showed up, 
> > 
> > - IPVS refcont leak 
> > - unpriviledged virtual terminal ioctls should be allowed 
> > to read function keys
> > 
> > So here goes -rc3.
> > 
> > Attaching the full changelog since this is probably the last -rc
> > release.
> >...
> 
> If there will be one more -rc, could you include my airo_cs fix?

Hi Adrian,

I think it can wait for the next -pre... Hope there wont be another -rc.
