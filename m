Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTKSTVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 14:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTKSTVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 14:21:00 -0500
Received: from imo-m05.mx.aol.com ([64.12.136.8]:61434 "EHLO
	imo-m05.mx.aol.com") by vger.kernel.org with ESMTP id S263957AbTKSTU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 14:20:59 -0500
Message-ID: <3FBBC28B.2010006@cs.com>
Date: Wed, 19 Nov 2003 14:20:43 -0500
From: Paul Nielsen <pnielsenz@cs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: menuconfig Error 1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 63.243.31.162
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to configure the Alsa sound options (select the "Advanced 
Linux Sound Architecture" and press <enter>,) "make menuconfig" fails 
with the message
"Q> scripts/Menuconfig: line 832: MCmenu78: command not found", for both 
the linux-2.4.22-10mdk and linux-2.4.22-10mdk kernel sources.

Paul Nielsen


