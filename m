Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270437AbTGZRJU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270440AbTGZRJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:09:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63618
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270437AbTGZRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:09:19 -0400
Subject: Re: Compilation problems under Sparc64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sylvain <thefunny@hosting42.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7x65lp2rne.fsf@sheena.arpej.net>
References: <7x65lp2rne.fsf@sheena.arpej.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059240039.1875.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2003 18:20:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-26 at 17:12, Sylvain wrote:
> Hi,
> 
>         I have try to compile  the 2.6.0-test1 under sparc64, I have a
>         ultra5 and  i obtain some  compilation problem with  floppy in
>         include/asm/floppy.h (asm-sparc64). I fix this problem with :

Already fixed in the -ac collection of addon patches I think. Your fix
is right

