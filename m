Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUHIIY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUHIIY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUHIIY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:24:26 -0400
Received: from be.zoznam.sk ([62.65.179.8]:58075 "EHLO be1.mail.zoznam.sk")
	by vger.kernel.org with ESMTP id S266204AbUHIIYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:24:25 -0400
Message-ID: <411734E1.5070508@lmxmail.sk>
Date: Mon, 09 Aug 2004 10:25:05 +0200
From: =?ISO-8859-2?Q?Mari=E1n_Tomko?= <macros@lmxmail.sk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; sk-SK; rv:1.7) Gecko/20040630
X-Accept-Language: sk, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: howto apply supermount patch only....
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have 2.6.7 kernel and I want only apply supermount patch. I downloaded 
supermount-ng204.diff from ck6 splitout.  I copied it into /usr/src.  
Here I  cd linux-2.6.7. From linux-2.6.7 I run patch -p1 < 
../supermount-ng204.diff

And I got this:
patch unexpectedly ends in middle of line
patch: **** Only garbage was found in the patch input.

What is the problem here? How to cerrectly applied this patch?

Thanx

Marian Tomko


PS - I am new in this... So please if it is trivial correct me.

