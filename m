Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSG2TEc>; Mon, 29 Jul 2002 15:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSG2TEc>; Mon, 29 Jul 2002 15:04:32 -0400
Received: from mail.wolnet.de ([213.178.16.8]:27328 "HELO wolnet.de")
	by vger.kernel.org with SMTP id <S317581AbSG2TEa>;
	Mon, 29 Jul 2002 15:04:30 -0400
From: Peter <pk@q-leap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15685.37510.23176.149164@gargle.gargle.HOWL>
Date: Mon, 29 Jul 2002 21:07:50 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Peter <pk@q-leap.com>,
       linux-kernel@vger.kernel.org, johannes@erdfelt.com
Subject: Re: oops with usb-serial converter
In-Reply-To: <1027969112.4101.16.camel@irongate.swansea.linux.org.uk>
References: <S.0001006613@wolnet.de>
	<20020729173724.GA10153@kroah.com>
	<1027969112.4101.16.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pk@q-leap.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Mon, 2002-07-29 at 18:37, Greg KH wrote:
 > > Can you see if the 2.5.29 kernel fixes this problem?  The usb-serial
 > > close() call has been modified to hopefully prevent this from happening
 > > in the 2.5 tree.
 > 
 > If you do - make a backup before you try it
 > 

Thx for the hint, since I'll need the laptop tomorrow at a customer,
I can try this the day after.

cheers,

	Peter

-- 
Peter Kruse <pk@q-leap.com>
Q-Leap Networks GmbH
+497071-703171

