Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVK1Uv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVK1Uv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVK1Uv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:51:58 -0500
Received: from mail.cesky-hosting.cz ([81.0.238.178]:58336 "EHLO
	mail.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S1750939AbVK1Uv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:51:57 -0500
Message-ID: <438B6E05.8070009@eq.cz>
Date: Mon, 28 Nov 2005 21:52:21 +0100
From: "0602@eq.cz" <0602@eq.cz>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051009)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: totally random "VFS: Cannot open root device"
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Please CC me your answers as I am not subscribed.)

I have a problem with 2.6.14.3 kernel (but this probably isn't too 
version-specific). I have a kernel which succesfully boots on totally 
random basis (cca 70% is success). My root partition resides on a SATA 
disc connected to a controller on Intel 6300ESB ICH southbridge (mb 
Intel se7320vp2). There is a reiserfs 3 filesystem on my root partition. 
Without any changes to configuration (os or bios or whatever) I 
sometimes get:

VFS: Cannot open root device "801" or unknown block(8,1)

Could this be some timeout issue, or indication of crappy hw? I've tried 
this about 10 times (immediately ctrl+alt+del on successfull boot or 
reset button on aforementioned panic) and I saw no regularities in this 
misbehaviour.

I sincerely appreciate any advice anyone can give.

Thanks,

r.
