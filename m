Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUEEUMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUEEUMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbUEEUMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:12:19 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28871 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264777AbUEEUMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:12:15 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Paul Jackson <pj@sgi.com>
Subject: Re: 2.6.6-rc3-mm2
Date: Wed, 5 May 2004 22:16:54 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org> <20040505090605.275a0d3a.pj@sgi.com>
In-Reply-To: <20040505090605.275a0d3a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405052216.54805.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 of May 2004 18:06, Paul Jackson wrote:
> This doesn't build for ia64 sn2_defconfig (probably not for numa in
> general). One of Andi's patches, numa-api-vma-policy-hooks.patch, is
> missing four #includes of linux/mempolicy.h.
>
> I have posted an updated version of that patch on Andi's numa thread of a
> month ago - cc'd to akpm.
>
> With this updated patch, this configuration builds.

Can you, please, send it again?  I can't find that one (well, my fault, but 
anyway ...),

RJW

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman


