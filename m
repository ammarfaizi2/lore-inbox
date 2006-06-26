Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWFZWWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWFZWWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWFZWWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:22:42 -0400
Received: from www17.your-server.de ([213.133.104.17]:34066 "EHLO
	www17.your-server.de") by vger.kernel.org with ESMTP
	id S1751268AbWFZWWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:22:41 -0400
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Message-Id: <28E89C23-DB5C-4FE3-92A4-B1B7B791B739@m3y3r.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
Date: Tue, 27 Jun 2006 00:22:12 +0200
X-Mailer: Apple Mail (2.750)
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But doesn't the whole imacfb commit only make sense while booting  
native from efi? and booting native from efi is in the moment only  
possible through this patch.

with kind regards
thomas

PS: and i can't boot via csm at the moment, because i use gpt only!  
and i don't want to mix up old style partition table and gpt like  
boot camp do.


