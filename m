Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbTCIAOz>; Sat, 8 Mar 2003 19:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbTCIAOz>; Sat, 8 Mar 2003 19:14:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12981
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262320AbTCIAOz>; Sat, 8 Mar 2003 19:14:55 -0500
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Bill Davidsen <davidsen@tmr.com>, Harald.Schaefer@gls-germany.com,
       Thomas.Mieslinger@gls-germany.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, aeb@cwi.nl
In-Reply-To: <20030308232351.GA3462@win.tue.nl>
References: <OFA9D69D12.A2BE6A15-ONC1256CE1.00344A6F-C1256CE1.0039609A@LocalDomain>
	 <Pine.LNX.3.96.1030308172559.4525D-100000@gatekeeper.tmr.com>
	 <20030308232351.GA3462@win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047173438.26884.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 09 Mar 2003 01:30:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 23:23, Andries Brouwer wrote:
> Really strange values, as if someone wanted to force a H=255.
> Must read current 2.4 source some time. What does hdparm say
> under 2.2.22?

What I'm trying to work out is why its not honouring PTBL
values in his case apparently. I don't care too much what shape
the disk is but I do care that if the partition table says
its this interpretation we use it

