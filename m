Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTJCSOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTJCSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:14:40 -0400
Received: from mail.g-housing.de ([62.75.136.201]:47784 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263819AbTJCSOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:14:06 -0400
Message-ID: <3F7DBC6E.3080804@g-house.de>
Date: Fri, 03 Oct 2003 20:14:06 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031002
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: crypto benchmark results with 2.6.0-test6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i run a coule of tests with different crypto ciphers on 2.6.0-test6 
(i386). machine is a AMD TB 900Mhz, 512MB RAM, X is running, but no 
further load. more info soon on the website, but here the results:

http://nerdbynature.de/bits/bench/prinz/2.6.0-test6/crypto/prinz-2.6.0-test6-aes.txt
http://nerdbynature.de/bits/bench/prinz/2.6.0-test6/crypto/prinz-2.6.0-test6-blowfish.txt
http://nerdbynature.de/bits/bench/prinz/2.6.0-test6/crypto/prinz-2.6.0-test6-cast5.txt
http://nerdbynature.de/bits/bench/prinz/2.6.0-test6/crypto/prinz-2.6.0-test6-cast6.txt
http://nerdbynature.de/bits/bench/prinz/2.6.0-test6/crypto/prinz-2.6.0-test6-serpent.txt
http://nerdbynature.de/bits/bench/prinz/2.6.0-test6/crypto/prinz-2.6.0-test6-twofish.txt


(keybits=128, but really, more info soon.)

Thanks,
Christian.
-- 
BOFH excuse #316:

Elves on strike. (Why do they call EMAG Elf Magic)

