Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271481AbRHPFof>; Thu, 16 Aug 2001 01:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271484AbRHPFoO>; Thu, 16 Aug 2001 01:44:14 -0400
Received: from ppp05.ts3.Gloucester.visi.net ([206.246.230.133]:17400 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S271481AbRHPFoE>; Thu, 16 Aug 2001 01:44:04 -0400
Date: Thu, 16 Aug 2001 01:11:57 -0400
From: Ben Collins <bcollins@debian.org>
To: jes@trained-monkey.org
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 64 bit locking in ieee1394/nodemgr.c
Message-ID: <20010816011157.B30381@visi.net>
In-Reply-To: <200108160439.f7G4d3b19502@savage.trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200108160439.f7G4d3b19502@savage.trained-monkey.org>; from jes@trained-monkey.org on Thu, Aug 16, 2001 at 12:39:03AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 12:39:03AM -0400, jes@trained-monkey.org wrote:
> Hi
> 
> The drivers/ieee1394/nodemgr.c driver tries to save cpu_flags in a 32
> bit type which is kinda bad.

Thanks. I'll apply all of the 1394 patches.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
