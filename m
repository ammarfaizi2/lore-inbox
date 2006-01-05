Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752096AbWAEHP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWAEHP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWAEHP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:15:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52872 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752096AbWAEHP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:15:57 -0500
Date: Thu, 5 Jan 2006 08:15:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alex Riesen <raa.lkml@gmail.com>
cc: xerces8 <xerces8@butn.net>, tech@lists.gnumonks.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible GPL violation in Canyon CN-WF514 WLAN router
In-Reply-To: <81b0412b0601040707r355da9eey1b6332d0563dd3a4@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601050815030.10161@yvahk01.tjqt.qr>
References: <WorldClient-F200512251652.AA52540032@butn.net> 
 <WorldClient-F200601032031.AA31410090@butn.net>
 <81b0412b0601040707r355da9eey1b6332d0563dd3a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On 1/3/06, xerces8 <xerces8@butn.net> wrote:
>>  Help disecting the FW package [4]. It is a ZIP archive containing
>>  a text file and a *.bin file. This *.bin file appears to be some kind
>>  of another archive, containing two files : webpages-6104ipc.bin
>>  and vmlinux.bin
>
>$ file WF514-200713T5.img
>WF514-200713T5.img: PPCBoot image
>
Why does not my "file" utility print that...!?

# rpm -q file
file-4.14-3


>Which probably (I didn't look) points to http://ppcboot.sourceforge.net/


Jan Engelhardt
-- 
