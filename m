Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbUDROXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 10:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDROXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 10:23:14 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:9682 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264170AbUDROXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 10:23:13 -0400
Message-ID: <4082819E.10106@free.fr>
Date: Sun, 18 Apr 2004 15:24:46 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Questions : disk partition re-reading
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 questions about disk partitioning under linux 2.6.x :

1/ Is it possible to alter a disk partition of a used disk and beeing 
able to use the modified partition without having to reboot the box?

2/ Is it possible to delete a disk partition without having the 
partition numbers changed?

My box is an AMD 2500+/Asus board with FC1 / 2.6.5.

Do I need to upgrade fdisk or use an other utility? Or do I need to 
apply a kernel patch?

Regards,
Remi
