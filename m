Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270480AbTGSCva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270482AbTGSCva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:51:30 -0400
Received: from modemcable029.129-200-24.mtl.mc.videotron.ca ([24.200.129.29]:19072
	"EHLO mainframe1.boofer.ca") by vger.kernel.org with ESMTP
	id S270480AbTGSCva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:51:30 -0400
Message-ID: <3F18B603.70405@yahoo.ca>
Date: Fri, 18 Jul 2003 23:07:47 -0400
From: Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030716
X-Accept-Language: en-ca
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1 Cannot login in X or console
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have succesfully compiled and booted the 2.6.0-test1 kernel. After i 
enter my username and password succesfuly the login window simply stays 
there:

Login: user <enter>
Password: xxxx<enter>
<freezes>

Same thing with gdm. I do not have this problem with 2.4.21+swsup+preempt.
There is no error written in the system log.
Is it possible that PAM + 2.6.0-test1 results in this problem ?
The single runlevel works fine.(booted with single as kernel arg)
I am running gentoo.

Any insight appreciated.

Joe

