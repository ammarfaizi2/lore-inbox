Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTD2SW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTD2SW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:22:29 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:10489 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S262123AbTD2SW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:22:28 -0400
Message-ID: <3EAEC5BC.3070008@cox.net>
Date: Tue, 29 Apr 2003 13:34:36 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question regarding inactive memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a bit of a newbie'ish question, and maybe a bit off-topic, 
but is there any way for me to remove inactive memory, either explicitly 
or implicitly? I have 512MB of PC2700 SDRAM, but my system is constantly 
eating into the swap I have on my system since I have usually about 
140-300MB of inactive (and dirty) RAM and usually about only 250MB in 
active memory. Is there a way for me to correct this bad memory usage 
without having to reboot? If patching the kernel would be a possible 
route to venture to, I'm game.

Any suggestions or comments are welcome.

Thank you all!
David

