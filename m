Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbUB0Mky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUB0Mky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:40:54 -0500
Received: from mxpool.datanet.hu ([194.149.13.165]:19470 "EHLO mx1.datanet.hu")
	by vger.kernel.org with ESMTP id S262755AbUB0Mkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:40:49 -0500
Message-ID: <403F4B58.1010901@flexys.hu>
Date: Fri, 27 Feb 2004 15:51:20 +0200
From: Tibor Kendl <kendl@flexys.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Set gcc to kernel header path
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mailing list members!

I'd like to know, how do you solve this problem on your own systems. 
I've installed a linux distribution with a 2.2.18 kernel, than i've 
downloaded, compiled and installed a 2.6.2 kernel. How can i make, if i 
want to compile any application ( like Samba, Apache, KDE, etc...), the 
gcc compiler use the '/usr/src/linux-2.6.2/include' header path instaead 
of the '/usr/include' for such include directories like 'linux', 'asm', 
'asm-generic', etc...?

Yours
Tibor Kendl

