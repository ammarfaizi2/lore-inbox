Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUGIPCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUGIPCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUGIPCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:02:23 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:4997 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264954AbUGIPCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:02:13 -0400
Date: Fri, 9 Jul 2004 16:01:11 +0100
From: Dave Jones <davej@redhat.com>
To: Stefan Reinauer <stepan@openbios.org>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Erik Rigtorp <erik@rigtorp.com>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709150111.GA3891@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stefan Reinauer <stepan@openbios.org>,
	Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
	Erik Rigtorp <erik@rigtorp.com>, linux-kernel@vger.kernel.org,
	pavel@ucw.cz
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040709144859.GA18243@openbios.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709144859.GA18243@openbios.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 04:48:59PM +0200, Stefan Reinauer wrote:

 > On the other hand, the jpeg decoder is 8k object size - less than the
 > dozens of gzip/gunzip algorithms in the kernel, so complaining sounds a
 > little foolish to me.

The zlibs should be consolidated these days, I remember an effort
about 18 months back to do so at least. Did any new ones get introduced
since then ?

 > Whether one wants retro text messages or a graphical bootup mechanism is
 > sure a philosophical thing. IMHO starting X that early is not an option.

It works surprisingly well.

		Dave

