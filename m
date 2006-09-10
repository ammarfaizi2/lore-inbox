Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWIJBzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWIJBzr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 21:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWIJBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 21:55:47 -0400
Received: from gw.goop.org ([64.81.55.164]:51150 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965084AbWIJBzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 21:55:46 -0400
Message-ID: <45036A5B.3070402@goop.org>
Date: Sat, 09 Sep 2006 18:28:59 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserve a boot-loader ID number for Xen
References: <45035472.8000506@goop.org> <20060910012029.GA26959@redhat.com>
In-Reply-To: <20060910012029.GA26959@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  >  				4 for ETHERBOOT
>  > +				5 for ELILO
>  > +				7 for GRuB
>  > +				8 for U-BOOT
>  > +				9 for Xen
>  >  				V = version
>  >  0x211	char		loadflags:
>
> Is there a reason 6 has been skipped ?
>   

HPA told me to use 9.  Maybe there's an unofficial user for 6?

    J

