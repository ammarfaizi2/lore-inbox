Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVBWWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVBWWDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVBWWCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:02:16 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:7097 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261616AbVBWWBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:01:04 -0500
Message-ID: <421CFD17.7070107@ens-lyon.org>
Date: Wed, 23 Feb 2005 23:00:55 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
References: <20050223014233.6710fd73.akpm@osdl.org> <421CC959.3070405@ens-lyon.org> <20050223212433.GA31281@isilmar.linta.de>
In-Reply-To: <20050223212433.GA31281@isilmar.linta.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski a écrit :
>>>+pcmcia-bridge-resource-management-fix.patch
> 
> is responsible for this "no resource available" message, because the other
> ones relate to other areas.

Yes, good catch, reverting it makes PCMCIA work again.
Let me know if you want me to test some patches.

Thanks,
Brice
