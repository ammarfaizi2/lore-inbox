Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTHWRAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTHWQ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:58:20 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:46753 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262979AbTHWPUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:20:23 -0400
Message-ID: <3F478636.3060002@cox.net>
Date: Sat, 23 Aug 2003 08:20:22 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: ACPI breaks IDE/USB
References: <1061613751.897.12.camel@kahlua>
In-Reply-To: <1061613751.897.12.camel@kahlua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Lieverdink wrote:

> When I enable ACPI on 2.6.0-test4 (also on 2.6.0-test3-*), the kernel no
> longer recognises my IDE controller and drops down to PIO mode for
> harddisk access. Additionally, USB devices don't get detected.

I'm running -test4 here with ACPI and have no trouble with USB devices.

> The system is an Athlon 2400+ on a Gibabyte GA-7VAXP mainboard. (KT400)

My system is an Athlon 1000 on an MSI KT266-based board.


