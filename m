Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWGTSkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWGTSkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 14:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWGTSkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 14:40:14 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:5746 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750890AbWGTSkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 14:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Kxd4DQMIwJEP3N8WdGfcvIkFbAJUD/Fdb1AYmKgbs8xX0m1FgTUa7ND6LkpHgU7SJ+1AiyHDYWzTUUHkcMCrGp1u0TrWgyke0Nvrz/D4+IVlXvTBSwvlzXtFnibkVzy+LaMeLBCeoN2xQbgIC9XH7sFgHYYU/OCgZYdliYyZk90=
Message-ID: <fc94aae90607201140m6d50b8d0qa547a93e14babb66@mail.gmail.com>
Date: Thu, 20 Jul 2006 19:40:12 +0100
From: "Michael Lothian" <mike@fireburn.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Status of the T-Mobile 3G PCMCIA Card
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: da8ebf40e9868494
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've recently subscribed to T-Mobile's 3G service for my laptop. I
found v little info on the card but heard a few success stories with
the Vodafone card with Linux.

Upon getting the card I've not realised my mistake and it appears that
it isn't as simple as I'd hoped.

Has anyone had any success with this card at all?

The lspci out put is:

04:00.2 Network controller: Option N.V. Qualcomm MSM6275 UMTS chip
        Flags: medium devsel, IRQ 17
        Memory at 52040000 (32-bit, non-prefetchable) [disabled] [size=2K]
04:00.2 0280: 1931:000c

pccard: CardBus card inserted into slot 0 is what dmesg says

And nothing appears under lsusb

I'd be grateful for any help anyone can offer because if I can't get
it to work I'll need to return it within the "cooling down" period
which is the next few days and be locked into an 18 month contract

Thanks again

Mike
