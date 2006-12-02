Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423743AbWLBLjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423743AbWLBLjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423727AbWLBLjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:39:45 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:5275 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1423710AbWLBLjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:39:40 -0500
Message-ID: <457165F8.5080504@scientia.net>
Date: Sat, 02 Dec 2006 12:39:36 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061124)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Karsten Weiss <knweiss@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net>	<Pine.LNX.4.64.0612021048200.2981@addx.localnet> <20061202113752.47dab7c6@localhost.localdomain>
In-Reply-To: <20061202113752.47dab7c6@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------000509090102030506030602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509090102030506030602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alan wrote:
> See the thread http://lkml.org/lkml/2006/8/16/305
>   

Hi Alan.

Thanks for your reply. I've read this thread already some weeks ago....
but from my limited knowledge I understood, that this was an issue
related to a SCSI adapter or so. Or did I understand this wrong. And as
soon as he removed the card everything was fine.

I don't have any PCI SCSI cards,... (but I have an onboard LSI53C1030
controller).
The only cards I have are:
PCIe bus (two slots):
Asus Nividia 7800GTX based card

PCI bus: no card (one slot):
no card

PCI-X bus A (100MHz) (two slots):
Hauppauge Nova T 500 Dual DVB-T card (which is actually a "normal" PCI
card,.. but should be compatible with PCI-X)
TerraTec Aureon 7.1 Universe Soundcard (which is actually a "normal" PCI
card,.. but should be compatible with PCI-X)

PCI-X bus B (133MHz) (one slots):
no card



Chris.

--------------000509090102030506030602
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------000509090102030506030602--
