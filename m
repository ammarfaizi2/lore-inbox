Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbUAETud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUAETud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:50:33 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:19944 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S264944AbUAETu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:50:26 -0500
From: Andrew Walrond <andrew@walrond.org>
To: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird problems with printer using USB
Date: Mon, 5 Jan 2004 19:50:22 +0000
User-Agent: KMail/1.5.4
References: <20040105192430.GA15884@DervishD>
In-Reply-To: <20040105192430.GA15884@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051950.23418.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 Jan 2004 7:24 pm, DervishD wrote:
>
> kernel: host/usb-uhci.c: interrupt, status 2, frame# 682
> kernel: printer.c: usblp0: nonzero read/write bulk status received: -110
> kernel: printer.c: usblp0: error -84 reading printer status
> kernel: printer.c: usblp0: removed
>

I had very similar messages (from memory), tried all sorts of different kernel 
versions, options, usb patches.... I even exchanged the usb cable. After a 
week I was ready to throw the **** printer out the window, when by chance I 
tried a shorter usb cable and it's worked perfectly ever since. I know it 
sounds unlikely (all the cables were within the 10ft allowed for usb1), but 
it worked for me. Might be worth a try.

Andrew Walrond

