Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbSLTI6p>; Fri, 20 Dec 2002 03:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267755AbSLTI6o>; Fri, 20 Dec 2002 03:58:44 -0500
Received: from mail.set-software.de ([193.218.212.121]:52376 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP
	id <S267754AbSLTI6o> convert rfc822-to-8bit; Fri, 20 Dec 2002 03:58:44 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 20 Dec 2002 09:05:55 GMT
Message-ID: <20021220.9055528@knigge.local.net>
Subject: RE: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 seri es cards
To: Adam Radford <aradford@3WARE.com>
CC: "'Dave Jones'" <davej@codemonkey.org.uk>, Nathan Neulinger <nneul@umr.edu>,
       linux-kernel@vger.kernel.org, uetrecht@umr.edu
In-Reply-To: <A1964EDB64C8094DA12D2271C04B812672C927@tabby>
References: <A1964EDB64C8094DA12D2271C04B812672C927@tabby>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> 3ware supports 6, 7, and 8000 series cards with a single driver in
> 2.2, 2.4, and 2.5 trees.

<snip>
scsi0 : 3ware Storage Controller 1.02.00.006
scsi : 1 host.
  Vendor: 3ware     Model: 3w-xxxx           Rev: 1.0
  Type:   Direct-Access                      ANSI SCSI revision: 00
</snip>

would it be hard to add the 3ware model? "3w-xxxx"... hmmmm... 
currently I want to buy some more controllers and want to get the same 
as I currenty have - but I really can't remember which ones I own 
;-)))) 

And I don't want to reboot (hey, I would loose my uptime) ;)))


I now run these controllers on 6 of my 6 servers and all run without 
problems. Isn't it time to change the driver's status? Iirc it is 
still marked "experimental"....


Bye
  Michael





