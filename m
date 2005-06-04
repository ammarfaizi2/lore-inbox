Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFDKNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFDKNj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFDKNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 06:13:39 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:63717 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261213AbVFDKNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 06:13:39 -0400
Message-ID: <42A17EE3.2070907@tiscali.de>
Date: Sat, 04 Jun 2005 12:13:55 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG | ACPI broken in 2.6.12-rc5
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I tried 2.6.12-rc5 - my screen became black and nothing happend. I turned off ACPI (apci=off) and it worked, but on powering off I had the same problem and I was not able to use ACPI (acpi=off :)). The same is true for 2.6.12-rc5-mm2.

Matthias-Christian Ott
