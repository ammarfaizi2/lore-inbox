Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUJWKXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUJWKXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUJWKWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:22:23 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:41933 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S266473AbUJWKUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:20:15 -0400
Date: Sat, 23 Oct 2004 12:20:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jean Delvare <khali@linux-fr.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: bkbits - "@" question
In-Reply-To: <20041023121452.1e82a758.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.53.0410231218470.21920@yvahk01.tjqt.qr>
References: <2SmNe-6MO-1@gated-at.bofh.it> <2SqR0-10Q-9@gated-at.bofh.it>
 <20041023121452.1e82a758.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Larry McVoy asked:
>> The web pages on bkbits.net contain email addresses.  This is
>> probably about a 4 year too late question but would it help reduce
>> spam if we did something like  s/@/ (at) / for all those addresses?
>>
>> * Christoph Hellwig answered:
>> No.
>
>Why not, please?

Counter-example... when I stopped posting to NNTP, the amount of spam also
decreased. Probably because the bots only skim a fixed timeperiod. In a long
term, I think it's a good choice to replace it. Maybe some PHP magic that
either puts <at>, [at] or (at) randomly there for each page request.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
