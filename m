Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSJJVu2>; Thu, 10 Oct 2002 17:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSJJVu1>; Thu, 10 Oct 2002 17:50:27 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35758 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262417AbSJJVty>; Thu, 10 Oct 2002 17:49:54 -0400
Subject: Re: Xbox Linux Kernel Patches Questions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Steil <mist@c64.org>
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Xbox-linux-devel@lists.sourceforge.net
In-Reply-To: <333B8114-DC98-11D6-B7BF-003065E1FB16@c64.org>
References: <333B8114-DC98-11D6-B7BF-003065E1FB16@c64.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 23:06:35 +0100
Message-Id: <1034287595.6462.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 22:35, Michael Steil wrote:
> > Can you tell the xbox by the subsystem id on the root bridges ?
> 
> Yes, these are unique.

> Where would we put out Xbox detection code? If it detects the Xbox as 
> described above, CONFIG_XBOX_SUPPORT will depend on CONFIG_PCI.

Which seems fair enough. ISA bus X-box systems are suprisingly rare


