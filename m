Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVBKGHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVBKGHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVBKGHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:07:07 -0500
Received: from mail02.hansenet.de ([213.191.73.62]:63364 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262187AbVBKGHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:07:04 -0500
Message-ID: <420C4B9A.6020900@web.de>
Date: Fri, 11 Feb 2005 07:07:22 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to disable slow agpgart in kernel config?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the agpgart backend is now always compiled in and selected with 2.6.11-rc3 
x86_64. I can delete or disable it in the config, it is always back written.

Is this the default future behaviour? The eg Nforce3 AGP is on a normal 
desktop so slow on 2D and also in 3D mode a lot slower and all nvidia 
kernel driver users can not more use the really faster nv_agp.

Greetings,
Marcus
