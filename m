Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVDBUTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDBUTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDBUTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:19:13 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:58818 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261253AbVDBUTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:19:10 -0500
Message-ID: <424EFE37.8050903@colorfullife.com>
Date: Sat, 02 Apr 2005 22:19:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Liontooth <liontooth@cogweb.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ICS1883 LAN PHY not detected
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Gigabyte's K8NS Ultra-939 mobo has a 100/10 LAN PHY chip, ICS1883, which
>isn't detected by the 2.6.12-rc1 kernel (and likely not previous kernels).
>
>  
>
The board is a nVidia nForce board, correct? Then please try the 
forcedeth network driver ("Reverse Engineered nForce Ethernet support").

--
    Manfred
