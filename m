Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUFUEIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUFUEIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 00:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUFUEIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 00:08:38 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:14862 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S266002AbUFUEIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 00:08:36 -0400
Message-ID: <40D65F09.8090909@snapgear.com>
Date: Mon, 21 Jun 2004 14:07:37 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.7-uc0 (MMU-less fixups)
References: <40D65A88.8080601@snapgear.com> <20040621035417.GY1863@holomorphy.com>
In-Reply-To: <20040621035417.GY1863@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

William Lee Irwin III wrote:
> On Mon, Jun 21, 2004 at 01:48:24PM +1000, Greg Ungerer wrote:
> 
>>An update of the uClinux (MMU-less) fixups against 2.6.7.
>>A few more things merged in 2.6.7, so only a handful of patches
>>for general uClinux and m68knommu.
>>http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.7-uc0.patch.gz
>>Change log:
>>. merge linux-2.6.7                          me
>>. more Feith hardware support                Werner Feith
>>. stop 5282 pit timer from going backwards   me/Felix Daners
>>. fix PHY race confition in FEC driver       Philippe De Muyter
>>. fix OOM killer for non-MMU configs         Giovanni Casoli
> 
> 
> Could you send the OOM killer fix out to mainline?

Yep, that one is definately geting submitted to Linus.
(Within the next 24 hours).

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
