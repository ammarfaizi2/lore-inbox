Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282961AbRLDJbz>; Tue, 4 Dec 2001 04:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283000AbRLDJbQ>; Tue, 4 Dec 2001 04:31:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19453
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283028AbRLDJbD>; Tue, 4 Dec 2001 04:31:03 -0500
Date: Tue, 4 Dec 2001 01:30:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-aacraid-devel@dell.com,
        aacraid@adaptec.com
Subject: Re: Aacraid driver 0.9.9ac
Message-ID: <20011204013052.G5320@mikef-linux.matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-aacraid-devel@dell.com,
	aacraid@adaptec.com
In-Reply-To: <E16ArGD-0006XU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ArGD-0006XU-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 11:27:44AM +0000, Alan Cox wrote:
> This should be everything needed. It tidies up all the loose ends. This
> driver is IMHO now ready to go into the mainstream with an experimental tag.
> 
> 	ftp://ftp.linux.org.uk/pub/linux/alan/aacraid-0.99ac1.diff
> 
> give it a good hammering.

Dell 2400

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:02.0 PCI bridge: Intel Corp.: Unknown device 0962 (rev 01)
00:02.1 Memory controller: Dell Computer Corporation PowerEdge Expandable
RAID Controller 2/Si (rev 01)
00:08.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:0e.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:06.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)

It hung right after printing "Red Hat raid driver"

Interrupts seem to be off.  no keyboard response to caps lock or sysrq.

I can supply .config if desired...

mf
