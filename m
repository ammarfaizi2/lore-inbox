Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVEQJGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVEQJGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 05:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVEQJGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 05:06:48 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:29093 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261336AbVEQJGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 05:06:46 -0400
Message-ID: <4289B423.7050407@ens-lyon.org>
Date: Tue, 17 May 2005 11:06:43 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2
References: <20050516021302.13bd285a.akpm@osdl.org>
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/

Hi Andrew,

Cardmgr does not automatically start my pcmcia wireless card anymore.
orinoco modules are not loaded at all.
I still can modprobe orinoco_cs to get my wireless to work.

Cardmgr says this when starting:
cardmgr[27367]: no pcmcia driver in /proc/devices

Is this a feature related to the upcoming deprecation of cardctl ?
Am I supposed to use pcmcia-utils ?

Thanks,
Brice
