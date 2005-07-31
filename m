Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVGaWQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVGaWQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVGaWQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:16:53 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:61320 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261994AbVGaWPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:15:21 -0400
Message-ID: <42ED4D73.9090903@web.de>
Date: Mon, 01 Aug 2005 00:15:15 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alexey Dobriyan <adobriyan@gmail.com>, Natalie.Protasevich@UNISYS.com,
       Andrew Morton <akpm@osdl.org>, Alexander Fieroch <fieroch@web.de>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org>	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>	 <20050615143039.24132251.akpm@osdl.org>	 <1118960606.24646.58.camel@localhost.localdomain>	 <42B2AACC.7070908@web.de>	 <1119011887.24646.84.camel@localhost.localdomain>	 <42B302C2.9030009@web.de> <9a874849050617101712b80b15@mail.gmail.com> <42CBAFC6.6040608@web.de> <42EAAFD4.4010303@web.de> <42EAD086.4010904@gmail.com>
In-Reply-To: <42EAD086.4010904@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Hello Alexander,
> 
> do you run
> A.) SATA in Enhanced Mode
> B.) SATA+PATA or PATA operation mode?
> 
> This problem I can reproduce when I  set A.)+B.) in bios I
> exactly get the same behavior of confused cd - drives.

Yes, I'm running SATA in enhanced mode with SATA+PATA operation mode and 
I have to. Running it in compatibility mode (PATA+SATA) I cannot boot 
from the SATA drive.

Regards,
Alexander
