Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266873AbTGLBoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267123AbTGLBoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:44:55 -0400
Received: from CPE-203-51-27-111.nsw.bigpond.net.au ([203.51.27.111]:23547
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S266873AbTGLBox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:44:53 -0400
Message-ID: <3F0F6B86.46FF4A6A@eyal.emu.id.au>
Date: Sat, 12 Jul 2003 11:59:34 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5 - unresolved in hfsplus
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Here goes -pre5.
> J. A. Magallon:
>   o hfsplus: group Apple FS's and help text

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-pre5/kernel/fs/hfsplus/hfsplus.o
depmod:         mark_page_accessed


--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
