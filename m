Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129265AbQKRD1r>; Fri, 17 Nov 2000 22:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKRD1h>; Fri, 17 Nov 2000 22:27:37 -0500
Received: from quechua.inka.de ([212.227.14.2]:55594 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129097AbQKRD12>;
	Fri, 17 Nov 2000 22:27:28 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Missing ACKs with Linux 2.2/2.4?
Message-Id: <E13weBw-0003xE-00@calista.inka.de>
Date: Fri, 17 Nov 2000 06:36:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200011121428.RAA16557@ms2.inr.ac.ru> you wrote:
> Sorry, ignoring some values of timestamp is simply impossible.
> It is PAWS. One packet is more than enough to kill you. 8)

Hmm... Isnt this only important for the first SYN with a Zero Timestamp
which is not very critical for PAWS?

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
