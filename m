Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWCURou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWCURou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCURot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:44:49 -0500
Received: from terminus.zytor.com ([192.83.249.54]:5854 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751458AbWCURot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:44:49 -0500
Message-ID: <44203B86.5000003@zytor.com>
Date: Tue, 21 Mar 2006 09:44:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <20060320134533.febb0155.rdunlap@xenotime.net> <dvn835$lvo$1@terminus.zytor.com> <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603211840020.21376@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> 
> NAK. How much more names will you be going to mangle because of FAT 
> character restrictions? (< and > are one of the chars not allowed in FAT.)
> 

Uhm... that's what VFAT *does*...

	-hpa
