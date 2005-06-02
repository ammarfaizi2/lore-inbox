Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFBTGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFBTGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFBTGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:06:45 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:16797 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261247AbVFBTGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:06:41 -0400
Message-ID: <429F58CD.4020505@tiscali.de>
Date: Thu, 02 Jun 2005 21:06:53 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IA32 | [OFFTOPIC]: Segementation Question
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I'm currently doing some research on the IA32 Segementation Concept. But there's one thing I don't understand:
If I perform a far jump it looks like this:
jmp	16bit:32bit

The 16bit are representing the segement number and the 32bit the offset. But to what refers the 16bit? To the GDT or the current LDT?

--
Thanks

Matthias-Christian Ott
