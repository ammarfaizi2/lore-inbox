Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVFGOsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVFGOsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVFGOsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:48:50 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:52099 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261888AbVFGOsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:48:46 -0400
Message-ID: <42A5B3CB.4010006@ens-lyon.org>
Date: Tue, 07 Jun 2005 16:48:43 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org>
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/
> 
> - Added v9fs
> 
> - Various random fixes
> 
> - Probably a similar number of breakages

Hi Andrew,

I didn't see any breakage. But I get these two lines during boot:
yenta 0000:02:03.1: no resource of type 100 available, trying to continue...
yenta 0000:02:03.1: no resource of type 100 available, trying to continue...

Anyway, my PCMCIA slots seem to still work.

Brice
