Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVGZKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGZKOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVGZKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:14:45 -0400
Received: from ns2.suse.de ([195.135.220.15]:52109 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261398AbVGZKOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:14:44 -0400
Message-ID: <42E60D29.7010609@suse.de>
Date: Tue, 26 Jul 2005 12:15:05 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.9) Gecko/20050712 Thunderbird/1.0.5 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Puneet Vyas <vyas.puneet@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       abonilla@linuxwireless.org
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
References: <42E58483.2050602@gmail.com> <42E57ACD.8070909@linuxwireless.org> <42E57BD6.4090006@linuxwireless.org> <42E5904A.9050306@gmail.com>
In-Reply-To: <42E5904A.9050306@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Puneet Vyas wrote:

> ide : failed opcode was : unknown
> hdc : status error: status 0x00 { }

This is _not_ an USB cd writer but an IDE drive.
You may not just pull it out.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
