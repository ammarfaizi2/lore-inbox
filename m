Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290759AbSARRcC>; Fri, 18 Jan 2002 12:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290762AbSARRbw>; Fri, 18 Jan 2002 12:31:52 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:13326 "HELO
	mail.et6.tu-harburg.de") by vger.kernel.org with SMTP
	id <S290759AbSARRbp>; Fri, 18 Jan 2002 12:31:45 -0500
Message-ID: <3C485C00.8060102@tu-harburg.de>
Date: Fri, 18 Jan 2002 18:31:44 +0100
From: Sebastian Zimmermann <S.Zimmermann@tu-harburg.de>
Organization: Technische =?ISO-8859-1?Q?Universit=E4t?= Hamburg-Harburg
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011213
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I2O kernel oops with Promise SuperTrak SX6000
In-Reply-To: <E16Rc8x-0007Ha-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 > Please try 2.4.18pre3-ac first of all. That has one small detail
 > changed that may matter.

Alan,

thanks for the quick reply. The good news: 2.4.18pre3-ac2 works.

I now get the message
"i2o/iop0 reset rejected, trying to clear"

(this message does not appear when initialization by the BIOS was 
aborted manually at boot time.)

Whatever the problem is, the kernel seems to be able to handle the exception now.


Thanks again,

Sebastian

