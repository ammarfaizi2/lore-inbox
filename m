Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272810AbTG3IPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272811AbTG3IPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:15:13 -0400
Received: from www.13thfloor.at ([212.16.59.250]:2471 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272810AbTG3IPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:15:08 -0400
Date: Wed, 30 Jul 2003 10:15:16 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Stacy Redmond <stacy.redmond@overture.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel hangs during uncompress
Message-ID: <20030730081516.GD2593@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Stacy Redmond <stacy.redmond@overture.com>,
	linux-kernel@vger.kernel.org
References: <3F2743F7.7030302@overture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F2743F7.7030302@overture.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 09:05:11PM -0700, Stacy Redmond wrote:
> I am trying to run the 2.4.20 kernel on a Dell 2650, upgrading from 
> 2.4.18-5.  When I go to reboot the machine with the new kernel it comes 
> up and says uncompressing kernel and then hangs.  
> Dell 2650 1x2.0MHz 4GB Ram
> Linux 7.3 running 2.4.18-5
> Building a Vanilla RedHat kernel with HighMem patch 2.4.20

give us a chance, send some information ;)

for example the following would be helpful:

- .config for your kernel
- commands used to config/build/install 
- boot loader and kernel parameters ...

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
