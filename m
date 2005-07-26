Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVGZLL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVGZLL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 07:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGZLL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 07:11:28 -0400
Received: from ns.suse.de ([195.135.220.2]:16567 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261747AbVGZLJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 07:09:19 -0400
Message-ID: <42E619F4.4020707@suse.de>
Date: Tue, 26 Jul 2005 13:09:40 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.9) Gecko/20050712 Thunderbird/1.0.5 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Puneet Vyas <vyas.puneet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       abonilla@linuxwireless.org
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
References: <42E58483.2050602@gmail.com> <42E5904A.9050306@gmail.com> <42E60D29.7010609@suse.de> <200507261406.16426.vda@ilport.com.ua>
In-Reply-To: <200507261406.16426.vda@ilport.com.ua>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Tuesday 26 July 2005 13:15, Stefan Seyfried wrote:
>> This is _not_ an USB cd writer but an IDE drive.
>> You may not just pull it out.
> 
> Interesting how he's connecting floppy to IDE ;]

The connector probably has IDE and USB, the floppy is using the USB
part, the CDRW is using the IDE part of the connector.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
