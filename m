Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277729AbRJWPJb>; Tue, 23 Oct 2001 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277728AbRJWPJL>; Tue, 23 Oct 2001 11:09:11 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:17030
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277727AbRJWPJJ>; Tue, 23 Oct 2001 11:09:09 -0400
Date: Tue, 23 Oct 2001 08:09:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org, azu@sysgo.de
Subject: Re: [PATCH] : preventing multiple includes of the same header file
Message-ID: <20011023080936.A13088@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.GSO.4.33.0110231618100.29108-100000@cbin2-view1.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0110231618100.29108-100000@cbin2-view1.cisco.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 04:20:35PM +0530, Manik Raina wrote:

> This patch should prevent multiple inclusions of some header
> files in include/asm-ppc/

I've changed _PPC_xxx_H to _ASM_xxx_H to match the rest of the headers.
This is now in the PPC bk tree, and will eventually hit Linus' tree,
thanks!

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
