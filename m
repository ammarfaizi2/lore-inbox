Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288010AbSAVCBw>; Mon, 21 Jan 2002 21:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289112AbSAVCBn>; Mon, 21 Jan 2002 21:01:43 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:57348 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S288010AbSAVCB1>; Mon, 21 Jan 2002 21:01:27 -0500
Message-ID: <3C4CC7F3.2167C558@delusion.de>
Date: Tue, 22 Jan 2002 03:01:23 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre3
In-Reply-To: <Pine.LNX.4.33.0201211728170.1263-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Lots of patches from people, and some that were dropped because of clashes

Hi,

Something between 2.5.2-pre11 and 2.5.3-pre3 broke wrt. init.

I'm getting several "init: open(/dev/console): Input/output error" messages
during startup now.

Do you want it narrowed down to the exact version that broke it?

Regards,
Udo.
