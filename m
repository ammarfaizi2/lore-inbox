Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbTAIQr3>; Thu, 9 Jan 2003 11:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbTAIQr3>; Thu, 9 Jan 2003 11:47:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53901
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266918AbTAIQr2>; Thu, 9 Jan 2003 11:47:28 -0500
Subject: Re: MB without keyboard controller / USB-only keyboard ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109114247.211f7072.skraw@ithnet.com>
References: <20030109114247.211f7072.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042134121.27796.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 17:42:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 10:42, Stephan von Krawczynski wrote:
> Hello all,
> 
> how do I work with a mb that contains no keyboard controller, but has only USB
> for keyboard and mouse?
> While booting the kernel I get:
> 
> pc_keyb: controller jammed (0xFF)

Does your BIOS do keyboard emulation ?


