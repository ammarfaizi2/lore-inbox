Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWFSOa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWFSOa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWFSOa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:30:28 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:2486 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932502AbWFSOa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:30:28 -0400
Date: Mon, 19 Jun 2006 16:30:07 +0200
From: Voluspa <lista1@comhem.se>
To: "Ojciec Rydzyk" <69rydzyk69@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, be-news06@lina.inka.de,
       jengelh@linux01.gwdg.de, greg@kroah.com
Subject: Re: Several errors in kernel
Message-Id: <20060619163007.2a681aaa.lista1@comhem.se>
In-Reply-To: <32124b660606190706g2d44414ck3860fd6ae82ec628@mail.gmail.com>
References: <20060619155824.7cc1ad6c.lista1@comhem.se>
	<32124b660606190706g2d44414ck3860fd6ae82ec628@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 16:06:26 +0200 Ojciec Rydzyk wrote:
> And what is wrong with my BIOS that kernel cannot allocate mem
> resource. What is the reason? (I just would like to know what should I
> post to my BIOS vendor :P)

It's a good question, so I'm cc:-ing the rest of the thread recipients
and adding Greg KH, so he can fight it out with anyone interested. Me,
I've given up on the issue. But as I predicted, it will hunt the list
until hidden...

Greg, here's my reply, sorry didn't quote anything from the original
message, but thread starts at:

http://marc.theaimsgroup.com/?t=115066436000002&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115066427121999&w=2

I wrote:
>>The nsxfeval is completely harmless and has been fixed in the
>>"ACPI: Subsystem revision 20060310" present in -mm kernels.
>>
>>The "Failed to allocate mem resource" is also harmless but Greg KH
>>has decided to not hide/fix it. Our BIOS vendors are to blame.
>>
>>For a summary see:
>>[Re: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel
>>hackers.]
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=113957514307078&w=2
>>
>>I started the thread at:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=113952620328363&w=2

Mvh
Mats Johannesson
--
