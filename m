Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWBMSlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWBMSlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWBMSlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:41:31 -0500
Received: from mail.majordomo.ru ([81.177.16.8]:19472 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S932409AbWBMSla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:41:30 -0500
Message-ID: <43F0F67A.8080001@nndl.org>
Date: Mon, 13 Feb 2006 21:13:30 +0000
From: "Nikolay N. Ivanov" <nn@nndl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.15.x - very slow disk-writing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone!

Disk-writing in 2.6.15.[1, 2, 3, 4] is very slowly on my computer. There 
is no such problem in 2.6.[10, 11, 12, 13, 14] with even configuration.

PC PIII, IDE HDD, 512RAM, Fs-type: ext3, swap partition: 512MB, 
Slackware 10.1

I tryed to install 2.6.15.x on other computer with other 
Linux-distribution (Mandriva) and the error stays.

-- 
Nikolay N. Ivanov
mailto: nn@nndl.org
