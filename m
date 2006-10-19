Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946322AbWJSSdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946322AbWJSSdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946320AbWJSSdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:33:10 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:22209 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S1946317AbWJSSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:33:08 -0400
Message-ID: <4537C4E2.2030000@molgaard.org>
Date: Thu, 19 Oct 2006 20:33:06 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060717 Debian/1.7.13-0.2ubuntu1
X-Accept-Language: en
MIME-Version: 1.0
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: speedstep-centrino: ENODEV
References: <EB12A50964762B4D8111D55B764A8454C1A4AF@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A4AF@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
 > Looking at the acpidump, looks like BIOS doesn't have this feature 
enabled. Can you also make sure you have latest BIOS for the platform 
and also, check in BIOS whether there are any options to enable this 
feature.
 >
 > Thanks,
 > Venki
 >

I flashed to bios to latest yesterday, but to no avail. There are no
options remotely connected to this in the setup menu :-(

Now, I don't mean to sound rude but I would like to know what changed,
as speedstep was working well in kernel 2.6.15, so my initial thoughts
contain the word regression. I still thank you for your interest though.

My best regards,

Sune Mølgaard

