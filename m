Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268583AbUGXNQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268583AbUGXNQa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 09:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268584AbUGXNQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 09:16:29 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:9648 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268583AbUGXNQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 09:16:29 -0400
Message-ID: <4102612E.8050500@kh3.org>
Date: Sat, 24 Jul 2004 15:16:30 +0200
From: =?ISO-8859-1?Q?Fran=E7ois_Visconte?= <fv@kh3.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: syscall stealing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
I'm new into kernel module programming and to improve my
knowledges i would like to create a simple kernel module.
My module should create a proc entry and increment a number
everytime a key is pressed.
To do that i have to "hijack" the "getkeycode" function but
i don't now how to do that with 2.6 kernel series.
Is anyone can help me telling me where to find documentation or
an existing module witch use such a technique

