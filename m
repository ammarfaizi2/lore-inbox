Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbTILAxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 20:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbTILAxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 20:53:17 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:26005 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261632AbTILAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 20:52:28 -0400
Subject: Re: Yet another query about sis963
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: =?ISO-8859-1?Q?Jo=E3o?= Seabra <seabra@aac.uc.pt>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0309111716140.1889@bigblue.dev.mdolabs.com>
References: <200309120050.21630.seabra@aac.uc.pt>
	 <Pine.LNX.4.56.0309111716140.1889@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063327853.4313.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 01:50:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 01:18, Davide Libenzi wrote:
> I don't know if Alan did actually fix the thing. Here you can find the IRQ
> routing patches :

Yes I rewrote the PCI IRQ routing code to fix this, the 440GX and some
other bits and make it a lot smaller and mostly __init code. Its in
2.4.23pre

