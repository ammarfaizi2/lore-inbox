Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSIKLjN>; Wed, 11 Sep 2002 07:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318721AbSIKLjM>; Wed, 11 Sep 2002 07:39:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:36079
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318638AbSIKLjM>; Wed, 11 Sep 2002 07:39:12 -0400
Subject: Re: ignore pci devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020911105131.GB5955@bytesex.org>
References: <20020910134708.GA7836@bytesex.org>
	<1031668032.31549.60.camel@irongate.swansea.linux.org.uk> 
	<20020911105131.GB5955@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 12:47:20 +0100
Message-Id: <1031744840.2768.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 11:51, Gerd Knorr wrote:
> > We already find the USB on the NSC SuperIO by peeking at the next
> > device along and checking if its the SuperIO functions 8)
> 
> It is a PCI card you can plug into some slot, not a motherboard ...

Yes but what other PCI devices are on that card ?

