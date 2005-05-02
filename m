Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVEBLl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEBLl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVEBLl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 07:41:27 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:10909 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261204AbVEBLlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 07:41:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=jEf1zPn09vd10W7MN9Y2MigCkNpbw66tVcKQuqlnVCpT9LUOUsGz6Hnn7mdnbUjcvqE+2siOdmldggtyTPzHyWep5kMl8RZH63tAnxwn258M3/H8fI3RO8aQUHyrHbohQbqUym9PeSr4LO20rVpAu4FPmk/xuEBmjt6nf/ZCJYE=
Message-ID: <42761265.8020807@gmail.com>
Date: Mon, 02 May 2005 13:43:33 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel bug ?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.pastebin.com/278569

testcase used

hack.pl/~c0de/5.c

compile and run using

strace -f 5

on my 2.6.12-rc3 kernel frow linus' git repo it
produces a bunch of oopses


regards

