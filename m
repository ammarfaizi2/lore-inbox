Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319054AbSHMUTv>; Tue, 13 Aug 2002 16:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319056AbSHMUTv>; Tue, 13 Aug 2002 16:19:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38394 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319054AbSHMUTu>; Tue, 13 Aug 2002 16:19:50 -0400
Subject: Re: Mongo local_irq_foo() patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020813150618.2d867b0e.arodland@noln.com>
References: <20020813150618.2d867b0e.arodland@noln.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 21:21:26 +0100
Message-Id: <1029270086.22847.101.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 20:06, Andrew Rodland wrote:
> split the patch up into 2 or 3 pieces and send to proper maintainers (if
> I can find them),

Feed it to the maintainers, maybe cc the list. sound/oss/ isa drivers
are unmaintained and scheduled for immediate termination anyway. PCI
ones I'm happy to review. For IRDA Jean Tourillhes is the maintainer and
definitely active

