Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRJOTBy>; Mon, 15 Oct 2001 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277950AbRJOTBo>; Mon, 15 Oct 2001 15:01:44 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:48132 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S277165AbRJOTBf>; Mon, 15 Oct 2001 15:01:35 -0400
Message-Id: <200110151902.f9FJ22Y52786@aslan.scsiguy.com>
To: christophe barbe <christophe.barbe.ml@online.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug 
In-Reply-To: Your message of "Mon, 15 Oct 2001 19:59:34 +0200."
             <20011015195934.C2665@turing> 
Date: Mon, 15 Oct 2001 13:02:02 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Attached to this mail is a patch (against 2.4.12) that export the PCI table
>for the hotplug code (via modules.pcimaps).
>
>I use it succesfully with my Adaptec APA1480A cardbus and the hotplug code.

Does the code in v6.2.4 of the aic7xxx driver work for you?  Other than
the "__NO_VERSION__" stuff (which I'll have to look into), it seems
identical to what is in that version of the driver.

--
Justin
