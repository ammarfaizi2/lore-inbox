Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264173AbTCXMps>; Mon, 24 Mar 2003 07:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264176AbTCXMps>; Mon, 24 Mar 2003 07:45:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60584
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264173AbTCXMpr>; Mon, 24 Mar 2003 07:45:47 -0500
Subject: Re: Query about SIS963 Bridges
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John M Collins <jmc@xisl.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7EABB0.9010505@xisl.com>
References: <3E7E43C3.2080605@xisl.com>
	 <1048467041.10727.100.camel@irongate.swansea.linux.org.uk>
	 <3E7EABB0.9010505@xisl.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048514988.25140.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 14:09:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try

	lspci -vxx -H1 -M

and see if thats different

