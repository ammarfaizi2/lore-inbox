Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTAKORq>; Sat, 11 Jan 2003 09:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267231AbTAKORq>; Sat, 11 Jan 2003 09:17:46 -0500
Received: from csl2.consultronics.on.ca ([204.138.93.2]:48092 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S267228AbTAKORp>; Sat, 11 Jan 2003 09:17:45 -0500
Date: Sat, 11 Jan 2003 09:26:31 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre3-acX oops
Message-ID: <20030111142631.GA6607@athame.dynamicro.on.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030110222008$074c@gated-at.bofh.it> <6599015.32TDcXEdQ7@adelaide.crans.org> <20030111123504.GB7731@darwin.gaia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030111123504.GB7731@darwin.gaia.net>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20030111 (Sat) at 1335:04 +0100, Vincent Hanquez wrote:
> On Sat, Jan 11, 2003 at 12:18:17PM +0100, Bertrand VIEILLE [Bébert] wrote:
> > EIP:    0010:[__free_pages_ok+637/672]    Tainted: P
> 
> Your kernel is tainted with a proprietary module.
> 
> >Process X (pid: 547, stackpage=f7257000)
> 
> and this is related to X. (nvidia proprietary module ?)
> Does this oops happen without the module ?
> 
Happened to me on two machines, one with nvidia running X and one that
doesn't run X at all and is untainted.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
