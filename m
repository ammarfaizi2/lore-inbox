Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUJVRiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUJVRiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUJVRfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:35:24 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:4508 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267507AbUJVR23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:28:29 -0400
Message-ID: <41794334.1080206@colorfullife.com>
Date: Fri, 22 Oct 2004 19:28:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Livelock with the shmctl04 test program from linux test project
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

>I'm seeing some sort of livelock on my dual amd64 with the shmctl04 test program
>
What do you mean with "sort of livelock"? Does it recover after a few 
minutes, does it recover if you send a signal to the shmctl04 test app? 
What is the contents of /proc/sysvipc/shm while xfce4 is running/not 
running?
--
    Manfred

