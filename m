Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267912AbRG3Uu1>; Mon, 30 Jul 2001 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRG3UuU>; Mon, 30 Jul 2001 16:50:20 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.17]:553 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267885AbRG3Utx>; Mon, 30 Jul 2001 16:49:53 -0400
Message-ID: <3B65C72E.3040508@chello.nl>
Date: Mon, 30 Jul 2001 22:44:30 +0200
From: Gerbrand van der Zouw <g.vanderzouw@chello.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <20010729222830.A25964@pckurt.casa-etp.nl> <20010730125012Z268576-720+7896@vger.kernel.org> <20010730154458.C4859@pckurt.casa-etp.nl> <20010730151538.A5600@debian> <20010730174653.D4859@pckurt.casa-etp.nl> <20010730204354.B26097@pckurt.casa-etp.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Kurt Garloff wrote:

 > It seemed to solved the trouble here on first sight (booting went further
 > then normal) but in the end did not turn out to solve the trouble here.
 > (Here means: MSI K7T Turbo (Ver.3) with AMD K7 1.2GHz.)

from your lspci output I seem to have exactly the same system as you 
have. I tried your patch (247-viakt133.diff) and came up with the same 
result here: it seemed to come further than last time with only 
2.4.6ac5, but then it crashed anyway. If you know of any BIOS parameters 
  that might help for this mobo, please let me know. I could not 
identify a parameter that does the same as the "DRAM Prefetch" for Abit 
mobos.

Regards,

Gerbrand van der Zouw


