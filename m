Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTDGMJA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbTDGMJA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:09:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34451
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263381AbTDGMI5 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:08:57 -0400
Subject: Re: [PATCH] Qemu support for PPC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030407064541.4E1312C04E@lists.samba.org>
References: <20030407064541.4E1312C04E@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049714507.2967.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 12:21:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 07:45, Rusty Russell wrote:
> I happens, though, whatever you may think.  It was done as a 2.4 patch
> because there's a tighter time constraint on entry into 2.4.

If it hasn't been generally accepted and cleaned up for 2.5 then it
shouldn't be going into 2.4

> This is not qemu specific, of course.  If you say it's not going in,
> then I'll accept that and do the work inside qemu.  It'll be damn
> slow, of course.

WTF should that make it slow ?

