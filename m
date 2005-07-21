Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVGUEzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVGUEzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVGUEzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:55:31 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:31496 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261622AbVGUEyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:54:11 -0400
Message-ID: <42DF2A6B.9050501@snapgear.com>
Date: Thu, 21 Jul 2005 14:54:03 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Obsolete files in 2.6 tree
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Are these files obsolete and could be deleted from tree.
> Does anybody use them? Could anybody compile them?
> 
[snip]
> fs/binfmt_flat.c

This is not obsolate, it is used by most MMUless architectures
as the primary executable file loader.

It compiles (and works).

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
