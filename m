Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265927AbUAEVZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUAEVZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:25:30 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:31976 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S265927AbUAEVZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:25:25 -0500
From: Andrew Walrond <andrew@walrond.org>
To: DervishD <raul@pleyades.net>
Subject: Re: Weird problems with printer using USB
Date: Mon, 5 Jan 2004 21:25:23 +0000
User-Agent: KMail/1.5.4
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040105192430.GA15884@DervishD> <200401051950.23418.andrew@walrond.org> <20040105202936.GE15884@DervishD>
In-Reply-To: <20040105202936.GE15884@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401052125.23985.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 Jan 2004 8:29 pm, DervishD wrote:
>
>     The cable is OK, I've tested with two cables and with a USB
> memory stick and all works ok. Seems like the printer doesn't like to
> have both the parallel cable and the USB cable plugged at the same
> time, but sometimes it worked, so... The final cause seems to be the
> size of the file I want to print. The larger, the more chances to
> fail. I'll try a new cable tomorrow, probably, but I'll give a newer
> kernel a try.
>

Well yes; both cables I tried worked fine with other devices, but with the 
printer (Laserjet 2400) the attenuation was obviously too much. With a 4ft 
cable, everything works fine.

Same error messages, and same symtoms, in that the bigger the file, the more 
likely the problem was to occur. Once the error had happened, the printer 
needed to be power-cycled before more prints would work.

I spent a week before xmas trying all latest kernels and Gregs latest usb 
patches, to no avail.

Let me know how it turns out :)

Andrew Walrond

