Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTKJMtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 07:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTKJMtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 07:49:18 -0500
Received: from smtp1.netcologne.de ([194.8.194.112]:2738 "EHLO
	smtp1.netcologne.de") by vger.kernel.org with ESMTP id S263427AbTKJMtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 07:49:17 -0500
Message-ID: <3FAF894C.4040806@interia.pl>
Date: Mon, 10 Nov 2003 13:49:16 +0100
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.5) Gecko/20031015
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compressed tmpfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was looking for something like tmpfs, but with additional feature - 
that all the files in that file system would be compressed.

I think it could be nice for one's RAM, especially in embedded 
devices/diskless stations, at a little expense of efficiency.

Is there such a feature in 2.4 kernel yet, and, if not, where should I 
look for it?

There is e2compr module on http://sourceforge.net/projects/e2compr/, but 
I'm not sure if it can be easily applied to 2.4.22 kernel (seems like 
it's for 2.4.17 kernels only).


Regards,

Tomasz Chmielewski

