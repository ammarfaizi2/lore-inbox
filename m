Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVAGNN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVAGNN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVAGNN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:13:59 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:63392 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261402AbVAGNN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:13:57 -0500
Message-ID: <41DE8AFB.9000305@ens-lyon.fr>
Date: Fri, 07 Jan 2005 14:13:31 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>, Mike Werner <werner@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
References: <20050106002240.00ac4611.akpm@osdl.org> <40f323d005010701395a2f8d00@mail.gmail.com>
In-Reply-To: <40f323d005010701395a2f8d00@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot a écrit :
> When i launch neverball (3d games), X get killed and I have the
> following error in dmesg (3d card 9200SE, xserver : Xorg) :
> 
> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held  
>                                                                  
> [drm:drm_unlock] *ERROR* Process 10657 using kernel context 0

Same *ERROR* here on my Compaq Evo N600c (Radeon Mobility M6 LY).
Xfree 4.3 from debian sarge doesn't crash but it's way too slow.
Vanilla 2.6.10 works fine.

Regards,

Brice
