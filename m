Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUBWOFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbUBWOFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:05:40 -0500
Received: from APlessis-Bouchard-101-1-4-11.w193-253.abo.wanadoo.fr ([193.253.212.11]:23052
	"EHLO smtp.localhost") by vger.kernel.org with ESMTP
	id S261867AbUBWOFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:05:35 -0500
To: Pavol Luptak <P.Luptak@sh.cvut.cz>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: SW RAID5 + high memory support freezes 2.6.3 kernel
References: <20040223024124.GA1590@psilocybus>
	<16441.33071.218049.163976@notabene.cse.unsw.edu.au>
	<20040222213011.7e1b8bbf.akpm@osdl.org>
	<20040223133503.GA1671@psilocybus>
From: syrius.ml@no-log.org
Date: Mon, 23 Feb 2004 15:05:27 +0100
In-Reply-To: <20040223133503.GA1671@psilocybus> (Pavol Luptak's message of
 "Mon, 23 Feb 2004 14:35:04 +0100")
Message-ID: <wazza.874qthopqw.fsf@message.id>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavol Luptak <P.Luptak@sh.cvut.cz> writes:

[...]
>> Retest on current 2.6.3-bk or 2.6.3-mm3 please.
>
> I tried 2.6.3-bk4 and seems it works without problems :)
> I'm going to copy about 300 GB data to this cryptoloop/RAID5 and report the
> eventual bugs....

same here with 2.6.3-mm3 + some dm patches i need.

-- 
S.
