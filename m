Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUBVUbu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbUBVUbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:31:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:40384 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261745AbUBVUbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:31:48 -0500
Message-ID: <403911AD.1030005@helmutauer.de>
Date: Sun, 22 Feb 2004 21:31:41 +0100
From: Helmut Auer <vdr@helmutauer.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Keyboard not working under 2.6.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:dc795559fd1207bef82c0d6ee61125c0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using an Intel810 MoBo with an infrared module/keyboard connected to
an onboard PS/2 connector.
With a 2.4.x kernel I get the message:
No AT keyboard found
but the keyboard works fine.
With a 2.6.2 kernel, I don't get this message, but the keyboard does not
work !!!
Any hints what I can try ? If I connect an USB keyboard, this will work, and also if I connect a "normal" PS/2 keyboard to that PS/2 pins. 

-- 
Helmut Auer, helmut@helmutauer.de 


