Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285125AbRLLJiU>; Wed, 12 Dec 2001 04:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285127AbRLLJiK>; Wed, 12 Dec 2001 04:38:10 -0500
Received: from ns.muni.cz ([147.251.4.33]:201 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S285125AbRLLJhv>;
	Wed, 12 Dec 2001 04:37:51 -0500
Date: Wed, 12 Dec 2001 10:37:48 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
Message-ID: <20011212103748.C14688@informatics.muni.cz>
In-Reply-To: <20011211222014.A13443@informatics.muni.cz> <20011211164059.C8227@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20011211164059.C8227@sventech.com>; from johannes@erdfelt.com on Tue, Dec 11, 2001 at 04:40:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:
: It may be because of a flaky cable. Are there any messages above that?
: 
	No messages from USB (some HW csum failures from the eth0, but
nothing related to my mouse). But you may be right, the mouse is connected
via a 5m extension USB cable.

: The device number changes because some process still has the first mouse
: open, so it assigns it the next available unused device.
: 
: There's a shared mouse device as well you might find more to your
: liking.

	I'll look at it, thanks. Fortunately I do not use more than one
USB mouse (altough this is a dual-{head,keyboard,mouse} configuration,
the other mouse is on the PS/2 port).

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
Having your own personal custom language dialect might be tempting but it is
normally something only the lisp community do.                    (Alan Cox)
