Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTENUxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTENUxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:53:18 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62366 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262827AbTENUxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:53:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 14 May 2003 14:05:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <b9uadh$16e$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.55.0305141404100.4539@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
 <Pine.LNX.4.55.0305141342030.4539@bigblue.dev.mcafeelabs.com>
 <b9uadh$16e$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.55.0305141342030.4539@bigblue.dev.mcafeelabs.com>
> By author:    Davide Libenzi <davidel@xmailserver.org>
> In newsgroup: linux.dev.kernel
> >
> > Not only. Like Ulrich was saying, the config documentation should heavily
> > warn the wild config guy about the consequences of a 'NO' over there.
> >
>
> How about creating a master option like we have for experimental?
> Something like "Allow removal of essential components?" (CONFIG_EMBEDDED)

I'd agree. Not showing them at all for std configurations is even better.


- Davide

