Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283002AbRLMCWv>; Wed, 12 Dec 2001 21:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283004AbRLMCWl>; Wed, 12 Dec 2001 21:22:41 -0500
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:15087 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S283002AbRLMCWa>; Wed, 12 Dec 2001 21:22:30 -0500
Message-ID: <3C18114F.F9C7A25A@ameritech.net>
Date: Wed, 12 Dec 2001 20:24:15 -0600
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Kasprzak <kas@informatics.muni.cz>
CC: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
In-Reply-To: <20011211222014.A13443@informatics.muni.cz> <20011211164059.C8227@sventech.com> <20011212103748.C14688@informatics.muni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine at work with a Logitech USB MouseMan+ and no extension
cable and a M$ usb keyboard I see the same thing.  Machine is a 
Dell with PII-400 and BX chipset.
  Happens during the night when not in use.

Jan Kasprzak wrote:
> 
> Johannes Erdfelt wrote:
> : It may be because of a flaky cable. Are there any messages above that?
> :
>         No messages from USB (some HW csum failures from the eth0, but
> nothing related to my mouse). But you may be right, the mouse is connected
> via a 5m extension USB cable.
> 
> : The device number changes because some process still has the first mouse
> : open, so it assigns it the next available unused device.
> :
> : There's a shared mouse device as well you might find more to your
> : liking.
> 
>         I'll look at it, thanks. Fortunately I do not use more than one
> USB mouse (altough this is a dual-{head,keyboard,mouse} configuration,
> the other mouse is on the PS/2 port).
> 
> -Y.
> 
> --
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Having your own personal custom language dialect might be tempting but it is
> normally something only the lisp community do.                    (Alan Cox)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
