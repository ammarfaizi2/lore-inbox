Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbTDACPn>; Mon, 31 Mar 2003 21:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbTDACPn>; Mon, 31 Mar 2003 21:15:43 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:16575 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261997AbTDACPm>; Mon, 31 Mar 2003 21:15:42 -0500
Date: Mon, 31 Mar 2003 19:26:27 +0000
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
cc: gibbs@scsiguy.com
Subject: Re: File system corruption under 2.4.21-pre5-ac1
Message-ID: <112820000.1049138786@caspian.scsiguy.com>
In-Reply-To: <3E88EA79.2060301@rackable.com>
References: <3E88EA79.2060301@rackable.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I'm seeing filesystem corruption on a number of intel SE7501wv2's under
> 2.4.21-pre5-ac1.  The systems are running Cerberus (ctcs).  They fail the
> kcompile, and memtst tests.

Are you running the aic79xx driver version embedded in that kernel version
or the latest from my site?

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

