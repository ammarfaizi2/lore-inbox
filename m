Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUGRKWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUGRKWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 06:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUGRKWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 06:22:50 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:42901 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263740AbUGRKWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 06:22:43 -0400
Message-ID: <40FA4F6D.9000906@t-online.de>
Date: Sun, 18 Jul 2004 12:22:37 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040717
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
References: <40F0E586.4040000@t-online.de> <20040711084208.GA1322@ucw.cz>
In-Reply-To: <20040711084208.GA1322@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: ZG5Kh0Zb8ezocIK2-WDCiLvGvjk2pZ1A3I09exH2sGttR973RmsIcV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>  
> Build the USB drivers into the kernel, or use the attached patch.
> If it helps, please tell me.
> 

The patch worked, as written before. Would it be possible
to permanently add it to the kernel for 2.6.8-rc3?


Many thanx

Harri
