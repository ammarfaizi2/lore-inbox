Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbRFRWDY>; Mon, 18 Jun 2001 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbRFRWDO>; Mon, 18 Jun 2001 18:03:14 -0400
Received: from SSH.ChaoticDreams.ORG ([64.162.95.164]:63364 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S261988AbRFRWDD>; Mon, 18 Jun 2001 18:03:03 -0400
Date: Mon, 18 Jun 2001 15:02:58 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: James Simmons <jsimmons@transvirtual.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
Message-ID: <20010618150258.C11691@ChaoticDreams.ORG>
In-Reply-To: <20010618122800.A10027@ChaoticDreams.ORG> <Pine.LNX.4.10.10106181456590.3113-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <Pine.LNX.4.10.10106181456590.3113-100000@transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jun 18, 2001 at 02:58:17PM -0700
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 02:58:17PM -0700, James Simmons wrote:
> > Yep, in fbmem.c the name entry is "sisfb" as opposed to just "sis". 
> 
> Agh!!! That needs to be fixed. 
> 
I've already fixed it in ruby..

Regards,

-- 
Paul Mundt <lethal@chaoticdreams.org>

