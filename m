Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWAQWFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWAQWFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWAQWFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:05:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34258 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964859AbWAQWFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:05:37 -0500
Date: Tue, 17 Jan 2006 23:05:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Antonio Vargas <windenntw@gmail.com>
cc: Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
In-Reply-To: <69304d110601171304h34c16fbfuf59df390c0fc58fd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601172259410.7756@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> 
 <20060117183916.399b030f.diegocg@gmail.com>  <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
  <Pine.LNX.4.61.0601172104350.11929@yvahk01.tjqt.qr>
 <69304d110601171304h34c16fbfuf59df390c0fc58fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Maybe the way to make modern-style linux development (post 2.5) more
>manageable for mere mortals is to stop integrating things when the
>shortlog is so big that it can't be posted to the mailing list? Less
>changes, easier to see if you are able to help testing ;)
>

<lots of irony>
Ridiculous, we'll never get there! Just look at 2.6.16-rc1 -
oh, there was no shortlog posted?
</lots of irony>

You probably don't know the mailing list, but I think it does not accept 
mails beyond 40K (some guess), but for sure it does not let 100KB through.
The 2.6.16-rc1 shortlogs would still need to shrank by 1.3MB to get where 
you want. However, if you read the description of [PATCH]es, you are 
already there (which is, though, a combination of goes-in and stays-out).



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
