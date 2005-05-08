Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVEHXT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVEHXT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 19:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVEHXTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 19:19:25 -0400
Received: from jagor.srce.hr ([161.53.2.130]:23245 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id S263002AbVEHXTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 19:19:23 -0400
Message-ID: <427E9E6A.9050500@spymac.com>
Date: Mon, 09 May 2005 01:19:06 +0200
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
References: <200505080226.43168.dtor_core@ameritech.net>
In-Reply-To: <200505080226.43168.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi dmitrty, i am now testing psmouse-resync-2.6.11.patch.gz on ms-600, 
with no problems so far... should i start testing 
psmouse-resync-2.6.11-v4.patch.gz or?

btw, cursed ms600 seems to be working properly for now, unfortunately i 
don't know if its because of the patch (no dmesg messages yet) or 
because  i opened it up and cleaned it :) oh yeah, it also fell to the 
floor couple of times, perhaps that's it :)
