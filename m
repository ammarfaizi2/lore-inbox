Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWGBLxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWGBLxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGBLxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 07:53:11 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:49806 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S932323AbWGBLxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 07:53:10 -0400
Message-ID: <44A7B3C2.5030208@bizmail.com.au>
Date: Sun, 02 Jul 2006 21:53:38 +1000
From: Jim <yh@bizmail.com.au>
Reply-To: yh@bizmail.com.au
Organization: yh@bizmail.com.au, yhus@users.sf.net;yh@paradise.net.nz;yhus@users.sf.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6 config for module load
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a device driver which can be configurated in kernel 2.4 to be a 
loadable module. But, in kernel 2.6, I made it as tristate in Kconfig. 
On make menuconfig list, I can only select it to [*]NewModule for kernel 
built-in, I cannot select it to [M]NewModule for loadable module 
(neither did I press key M or Space key produce [M]). Is it wrong to 
specify tristate in Kconfig to make a loadable module in kernel 2.6? Or 
what was I missing in kernel 2.6 config?

Thank you.

Jim


