Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSJZSrb>; Sat, 26 Oct 2002 14:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJZSrb>; Sat, 26 Oct 2002 14:47:31 -0400
Received: from hermes.domdv.de ([193.102.202.1]:264 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S261404AbSJZSra>;
	Sat, 26 Oct 2002 14:47:30 -0400
Message-ID: <3DBAE4A0.4090802@domdv.de>
Date: Sat, 26 Oct 2002 20:53:20 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rootfs exposure in /proc/mounts
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I do oversee the obious but:

can somebody please explain why rootfs is exposed in /proc/mounts (I do 
mean the "rootfs / rootfs rw 0 0" entry) and if there is a good reason 
for the exposure?

-- 
Andreas Steinmetz

