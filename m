Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWBAQOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWBAQOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWBAQOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:14:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17035 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422666AbWBAQOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:14:19 -0500
Date: Wed, 1 Feb 2006 17:14:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jiri Slaby <xslaby@fi.muni.cz>
cc: kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
In-Reply-To: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
Message-ID: <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>    I have some problem while booting inside linux,so
>>tried to boot in single user mode for some changes in
>>/etc/grub.conf.But iam not able to boot in single user
>>mode.It is giving error message as
>>
>> ds: no socket drivers loaded!
>> VFS: Cannot open root device "LABEL=/" or 00:00
>
>change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
>
is there a kernel patch that does allow it?


Jan Engelhardt
-- 
