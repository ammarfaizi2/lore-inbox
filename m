Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290735AbSAYULH>; Fri, 25 Jan 2002 15:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSAYUK5>; Fri, 25 Jan 2002 15:10:57 -0500
Received: from postal2.lbl.gov ([131.243.248.26]:45758 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S290735AbSAYUKm>;
	Fri, 25 Jan 2002 15:10:42 -0500
Message-ID: <3C51B99D.976D2546@lbl.gov>
Date: Fri, 25 Jan 2002 12:01:33 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Lavender <brian@brie.com>, linux-kernel@vger.kernel.org
Subject: Re: VAIO IRQ assignment problem of USB controller
In-Reply-To: <20020124173421.B8732@brie.com> <20020125003306.A9759@brie.com> <3C51A1D7.74539585@lbl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis wrote:
> 
> This is another device that Sony has decided to configure via ACPI.
> 
> You'll need to check out the Linux ACPI project, and see about getting
> the ACPI IRQ routing patch.
> 
> No, I don't know where it's at exactly..  try using google.
> 

Having just this problem occur...  My Sony VAIO R505tsk needed this for
not just the card slot, but the USB too!  (I'm running Sony's update
WinXP bios on it).

Here's the article with the patch:

http://groups.google.com/groups?hl=en&selm=linux.kernel.Pine.LNX.4.33.0201171620510.19753-100000%40chaos.tp1.ruhr-uni-bochum.de

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
