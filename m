Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSEELm3>; Sun, 5 May 2002 07:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSEELm2>; Sun, 5 May 2002 07:42:28 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:42624 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310666AbSEELm2>; Sun, 5 May 2002 07:42:28 -0400
Date: Sun, 5 May 2002 13:40:41 +0200
From: Erich Schubert <erich.schubert@mucl.de>
To: linux-kernel@vger.kernel.org
Subject: Broken URL Update for drivers/pci/quirks.c
Message-ID: <20020505114041.GA20668@marvin.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/pci/quirks.c references
  http://home.tiscalinet.de/au-ja/review-kt133a-1-en.html
which is now at
  http://www.au-ja.org/review-kt133a-1-en.phtml
(original german version is http://www.au-ja.org/review-kt133a-1.phtml)

I'll now try using quirk_viaetbf, too...
The system seems to run a bit better under high loads already with the
southbridge workaround enabled (well, "fastdep" segfaulted a few times,
but gcc hasn't segfaultet yet, this definitely is an improvement...)

Gruss,
Erich Schubert

--
erich@(mucl.de|debian.org)        --        GPG Key ID: 4B3A135C
A polar bear is a rectangular bear after a coordinate transform.
Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.
