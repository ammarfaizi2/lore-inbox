Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272204AbRH3NIg>; Thu, 30 Aug 2001 09:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272206AbRH3NI1>; Thu, 30 Aug 2001 09:08:27 -0400
Received: from denise.shiny.it ([194.20.232.1]:25993 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S272204AbRH3NIQ>;
	Thu, 30 Aug 2001 09:08:16 -0400
Message-ID: <XFMail.20010830150826.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <F206lZz02H67yRLVbND00001b0c@hotmail.com>
Date: Thu, 30 Aug 2001 15:08:26 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Do-Han Kim <shinywind@hotmail.com>
Subject: RE: bit field endian vs endian
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30-Aug-2001 Do-Han Kim wrote:
> Hello,
> In the linux kernel source tcp.h
> bit field endian is appeared.
> if the machine is the big endian machine, highest bit is alligned in the
> lowest location in byte?

Bits arrangement in bitfields is defined in the ABI.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

