Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRCHR0F>; Thu, 8 Mar 2001 12:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbRCHRZp>; Thu, 8 Mar 2001 12:25:45 -0500
Received: from scl-ims.phoenix.com ([134.122.1.73]:58122 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S129381AbRCHRZi>; Thu, 8 Mar 2001 12:25:38 -0500
Message-ID: <D973CF70008ED411B273009027893BA409728C@irv-exch.phoenix.com>
From: David Christensen <David_Christensen@Phoenix.com>
To: "'Stephen Torri'" <s.torri@lancaster.ac.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ACPI:system description tables not found.
Date: Thu, 8 Mar 2001 09:25:08 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Is there a BIOS setup option for enabling ACPI?  Make sure it is enabled.
Also attach a copy of the E820 output from dmesg.

David Christensen

> I am using kernel-2.4.2-ac12 (will try ac14). The motherboard is a
> Supermicro P6DBU. (I will need to check the board when I get home to
> confirm). I get the messages below when the system starts:
>
> acpi: system description tables not found
>
> The manufacturer says that there is support for acpi. So I willing to beat
> it around a bit to get the tables found. Any ideas where to start?
>
> Stephen
>
