Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRCAPfA>; Thu, 1 Mar 2001 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRCAPev>; Thu, 1 Mar 2001 10:34:51 -0500
Received: from kanga.kvack.org ([216.129.200.3]:14347 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129657AbRCAPep>;
	Thu, 1 Mar 2001 10:34:45 -0500
Date: Thu, 1 Mar 2001 10:30:48 -0500 (EST)
From: <kernel@kvack.org>
To: Ofer Fryman <ofer@shunra.co.il>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DECE@SALVADOR>
Message-ID: <Pine.LNX.3.96.1010301102756.2411B-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Ofer Fryman wrote:

> I managed to compiled e1000 for Linux 2.0.36-pre14, I can also load it
> successfully. 
> With the E1000_IMS_RXSEQ bit set in IMS_ENABLE_MASK I get endless interrupts
> and the computer freezes, without this bit set it works but I cannot receive
> or send anything.

Intel refuses to provide complete documentation for any of their ethernet
cards.  I recommend purchasing alternative products from vendors like 3com
and National Semiconduct who are cooperative in providing data needed by
the development community.


		-ben

