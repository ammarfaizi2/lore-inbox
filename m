Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284153AbRLYApE>; Mon, 24 Dec 2001 19:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284160AbRLYAoy>; Mon, 24 Dec 2001 19:44:54 -0500
Received: from atlante.atlas-iap.es ([194.224.1.3]:25356 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S284153AbRLYAoh>; Mon, 24 Dec 2001 19:44:37 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: IDE CDROM locks the system hard on media error
Date: Tue, 25 Dec 2001 01:44:20 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16Ifhc-0005p7-00@antoli.uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/01 23:28, Alan Cox shaped the electrons to say:

>> If it is DMAing and there is a 1us transaction delay it is toast.
>> Intel PIIX4 AB/EB is a NO-NO for doing ATAPI on.
>
>So we should set ATAPI devices on the PIIX4 to non DMA modes ?

I am having the same problem with a USB HTP cd-writer...

No messages at all.

-- 
  ricardo
Cuando usaba Mac, se reían porque no tenía línea de comandos.
Ahora que uso Linux, se ríen porque tengo línea de comandos.
