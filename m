Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTLMCLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTLMCLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:11:41 -0500
Received: from fep01.swip.net ([130.244.199.129]:57056 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP id S262882AbTLMCLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:11:40 -0500
Message-ID: <3FDA757A.2070507@yahoo.fr>
Date: Sat, 13 Dec 2003 03:12:10 +0100
From: jjluza <jjluza@yahoo.fr>
Reply-To: jjluza@yahoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-2 StumbleUpon/1.87
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6-test11-bk8] hdc: lost interrupt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error when I try :
cat /proc/ide/hdc/identify
where hdc is a pioneer atapi dvd reader (a104)
This command freeze, and I can't get my dvdrom reader responding anymore.

