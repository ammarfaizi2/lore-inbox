Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVLSKPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVLSKPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 05:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVLSKPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 05:15:38 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:58270 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932715AbVLSKPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 05:15:38 -0500
Message-ID: <43A6886F.6090606@ru.mvista.com>
Date: Mon, 19 Dec 2005 13:16:15 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SPI core function names
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI David,

one of the guys working on the SPI stuff with me noticed that he didn't 
feel conmortable with spi_sync name as it could be confused with the 
function that synchronizes between something and something else. So what 
if change spi_sync/spi_async to spi_transfer_sync/spi_transfer_async?

Vitaly
