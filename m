Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbQLGXmZ>; Thu, 7 Dec 2000 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbQLGXmF>; Thu, 7 Dec 2000 18:42:05 -0500
Received: from www.rccacm.org ([209.166.59.114]:6926 "EHLO www.rccacm.org")
	by vger.kernel.org with ESMTP id <S131641AbQLGXlt>;
	Thu, 7 Dec 2000 18:41:49 -0500
Date: Thu, 7 Dec 2000 14:56:29 -0800 (PST)
From: Bryan Whitehead <driver@rccacm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Disableing USB.
Message-ID: <Pine.LNX.4.21.0012071438020.3776-100000@www.rccacm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way I can disble a part of the kernel that is compiled into the
kernel? For example I'd like to pass this to lilo: "usb=disable" and then
the usb code is not loaded even though USB has been built into the kernel.

Is such a feature stupid? Or has this already been implemented?

It would be nice if this was generic and I could also pass things like
"procfs=disabled".

The resone I ask is a friend of mine got a new Sony Vaio Laptop that has
the ethernet card and USB device stepping on eachother. It would be nice
to pass to the Redhat/Mandrake/whatever installation boot disk usb=disable
so the ethernet card can work freely (he's doiung a ntwork install becasue
he has no CD-ROM), as he doesn't use any USB devices anyway.

-- 
---
Bryan Whitehead
Email: driver@rccacm.org
WorkE: driver@jpl.nasa.gov

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
