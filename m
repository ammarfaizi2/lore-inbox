Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTICNLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTICNLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:11:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42955 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262175AbTICNLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:11:22 -0400
Subject: Re: Driver Model
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jimwclark@ntlworld.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309021943.15875.jimwclark@ntlworld.com>
References: <200309021943.15875.jimwclark@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062594625.19058.27.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 14:10:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-02 at 19:43, James Clark wrote:
> 3. Will the practice of deliberately breaking some binary only 'tainted' 
> modules prevent take up of Linux. Isn't this taking things too far?

tainted doesn't break anything. tainted marks modules so we know they
are unsupported and every vendor, developer and the like can throw your
reports into the bitbucket. The binary vendor has our code we don;t have
theirs so they can go fix it.

As to "too far", the GPL is quite explicit and most people contributed
code on its basis. So its very unlikely that any binary only module is
legal in the first place. There is FSF code in the kernel, merged by
others and the FSF certainly feel that way.

If you want to run a binary unix system I'd recommend Mac OSx - its
rather nice.

Alan

