Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S314457AbSEBOkh>; Thu, 2 May 2002 10:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S314548AbSEBOkg>; Thu, 2 May 2002 10:40:36 -0400
Received: from [212.141.54.118] ([212.141.54.118]:53139 "EHLO mailweb8.inwind.it") by vger.kernel.org with ESMTP id <S314457AbSEBOkg> convert rfc822-to-8bit; Thu, 2 May 2002 10:40:36 -0400
Date: Thu,  2 May 2002 16:39:48 +0200
Message-Id: <GVHNEC$991A8E94982542D71AEE0A77EC1FCC48@inwind.it>
Subject: Serial port & Linux kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "antonelloderosa@inwind.it" <antonelloderosa@inwind.it>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "C. Scott Ananian" <cananian@lcs.mit.edu>
Cc: linux-kernel@vger.kernel.org
X-XaM3-API-Version: 1.1.9.1.39.1.2
X-SenderIP: 217.9.64.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I must control the serial port at kernel level, because I have to make several measurements of one-way delay between a source and a destination host, so while I set the DTR on the source host when I send the UDP packet, the destination host must be able to set by itself the RTS when it receives the packet.

I'm quite a beginner in Linux-kernel, so may you help me more?

Thanks again

Antonello 

