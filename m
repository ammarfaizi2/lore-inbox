Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S314444AbSEBOEp>; Thu, 2 May 2002 10:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S314446AbSEBOEo>; Thu, 2 May 2002 10:04:44 -0400
Received: from mailweb3.inwind.it ([212.141.54.113]:30626 "EHLO mailweb3.inwind.it") by vger.kernel.org with ESMTP id <S314444AbSEBOEo> convert rfc822-to-8bit; Thu, 2 May 2002 10:04:44 -0400
Date: Thu,  2 May 2002 16:04:22 +0200
Message-Id: <GVHLRA$D4027B2E0352B6518E8BA434D6CDC311@inwind.it>
Subject: Controlling the serial port at kernel level
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "antonelloderosa@inwind.it" <antonelloderosa@inwind.it>
To: "C. Scott Ananian" <cananian@lcs.mit.edu>
Cc: linux-kernel@vger.kernel.org
X-XaM3-API-Version: 1.1.9.1.39.1.2
X-SenderIP: 217.9.64.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Ananian,
I would control the serial port at kernel level; more precisely I've to set the DTR and RTS pins directly from the kernel, in the udp.c. In fact I've to generate a voltage transition on these pins whenever my host is going to send or receive an udp packet.

Can you help me?

Thanks a lot !!

Antonello

