Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318965AbSHTOM4>; Tue, 20 Aug 2002 10:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318959AbSHTOM4>; Tue, 20 Aug 2002 10:12:56 -0400
Received: from mail.iok.net ([62.249.129.22]:39690 "EHLO mars.iok.net")
	by vger.kernel.org with ESMTP id <S318965AbSHTOMz>;
	Tue, 20 Aug 2002 10:12:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Holger Schurig <h.schurig@mn-logistik.de>
To: linux-kernel@vger.kernel.org
Subject: Re: new driver: multimedia card (mmc) framework, patch against 2.4.19
Date: Tue, 20 Aug 2002 16:07:27 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208201607.27397.h.schurig@mn-logistik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the moment, access to the information required to write a driver for SD
> or SDIO requires signing and NDA that precludes the release of an open
> source driver, so only MMC is supported at this time.

I'm interested to write the device driver for the Intel PXA 250. See if this 
chip is uncrippled enought to get it working. I'm only trying to do the MMC 
part, I'm not interested in SD.

Do you by any chance have me a pointer to MMC related documentation (in other 
words: to the specs) ?

The MMC interface of the PXA250 processor is written in chaper 15 of the 
Developers's Manual from Intel, see 
http://developer.intel.com/design/pca/applicationsprocessors/manuals/278522-001.htm

