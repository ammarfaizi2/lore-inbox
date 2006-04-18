Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWDRXPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWDRXPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDRXPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:15:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60830 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750822AbWDRXPT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:15:19 -0400
X-Sasl-enc: 3gsLUdckUMPRUV0QP8vK2iDMSAuMQm8NnpPl4jtrTbgH 1145402084
Message-ID: <44457350.4040802@imap.cc>
Date: Wed, 19 Apr 2006 01:16:32 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISDN: unsafe interaction between isdn_write and isdn_writebuf_stub
References: <60xlD-5Y2-13@gated-at.bofh.it> <62rF9-2nN-7@gated-at.bofh.it>
In-Reply-To: <62rF9-2nN-7@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2006 04:30, Jesper Juhl wrote:
> No replies to this patch (below) at all, despite lots of people and
> lists on CC :-(
> Ohh well, adding akpm to CC so that perhaps the patch can make it into
> -mm and at least get some testing.

Yeah, apparently nobody wants to put much work into i4l anymore.
Everybody's waiting for it to be replaced by CAPI, only we don't quite
seem to be there yet.

Anyway, my development machine has been running with your patch for a
while, with no apparent ill effects. Although this hardly qualifies as
exhaustive testing, it does seem do indicate that the patch is on the
right track.

HTH
Tilman

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

