Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUJUD27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUJUD27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270529AbUJUD2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:28:17 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:32527 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S270524AbUJUDPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:15:01 -0400
Message-ID: <4177297E.6000707@snapgear.com>
Date: Thu, 21 Oct 2004 13:14:06 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-m68k@vger.kernel.org
Subject: Re: [uClinux-dev] Re: [PATCH] Add key management syscalls to non-i386
 archs
References: <3506.1098283455@redhat.com> <Pine.GSO.4.61.0410201840440.6837@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0410201840440.6837@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> On Wed, 20 Oct 2004, David Howells wrote:
> 
>>The attached patch adds syscalls for almost all archs (everything barring
>>m68knommu which is in a real mess, and i386 which already has it).
> 
> 
> m68nommu mirrors m68k now, but that patch doesn't seem to be in Linus' tree
> yet.

Yes, I have a patch to do that brings it into line with m68k.
I need to submit that a bunch of other patches. I am a little
behind :-)

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
