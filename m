Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTBESDW>; Wed, 5 Feb 2003 13:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTBESDW>; Wed, 5 Feb 2003 13:03:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43675
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261854AbTBESDV>; Wed, 5 Feb 2003 13:03:21 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ross Biro <rossb@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alan@redhat.com,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E4147A0.4050709@google.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
	 <3E3D6367.9090907@pobox.com>  <20030205104845.17a0553c.skraw@ithnet.com>
	 <1044443761.685.44.camel@zion.wanadoo.fr>  <3E414243.4090303@google.com>
	 <1044465151.685.149.camel@zion.wanadoo.fr>  <3E4147A0.4050709@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044472206.32062.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 05 Feb 2003 19:10:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 17:19, Ross Biro wrote:
> I've actually had a manufacturer tell me that they don't worry about the 
> spec, just making things work with Windows.

Its very common. As a customer always ask the vendor if they are 
compliant to each appropriate standard in writing. If they say yes it
has nice little liability issues should they be lying 8)


