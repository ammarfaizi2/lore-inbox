Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319191AbSHTQqi>; Tue, 20 Aug 2002 12:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319193AbSHTQqi>; Tue, 20 Aug 2002 12:46:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49848 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319191AbSHTQqh>;
	Tue, 20 Aug 2002 12:46:37 -0400
Message-Id: <200208201648.g7KGmkS02333@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2/2) discontigmem support for i386 against 2.4.20pre4: 
 discontigmem
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "20 Aug 2002 14:07:25 BST." <1029848845.22982.23.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Aug 2002 09:48:46 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  > On Tue, 2002-08-20 at 04:03, Patricia Gaughen wrote:
  > > Assumptions made: 
  > > 
  > >         - that the first node has at least 900Mb of memory
  > 
  > Is that assumption made for non NUMA too ?

No, this assumption is only for the i386 numa boxes.

 



