Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUJKOet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUJKOet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269013AbUJKOcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:32:53 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:34450 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269029AbUJKO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:29:12 -0400
Message-ID: <416A98B3.7050805@t-online.de>
Date: Mon, 11 Oct 2004 16:29:07 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4: Aiee on amd64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Govh4BZcoeDZsKOcYR-6CCDy+5kg1XQ5UTkTHHwDyi5h6g0CHFKbEl
X-TOI-MSGID: 7130fa0d-b657-4d75-8d7f-68d3dab2c4ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I installed 2.6.9-rc4 this morning, but it died at boot time
(a lot of hex output and something about "Aiee" :-). I tried
to redirect syslog to another host, but the error message did
not show up in the foreign log files.

Any idea how to catch this message? The problem seems to be
reproducable, and I would be glad to help.


Regards

Harri
