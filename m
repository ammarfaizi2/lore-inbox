Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVL3JYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVL3JYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 04:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVL3JYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 04:24:52 -0500
Received: from isilmar.linta.de ([213.239.214.66]:45756 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751228AbVL3JYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 04:24:51 -0500
Date: Fri, 30 Dec 2005 10:24:49 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pcmcia/cistpl.c: fix endian warnings
Message-ID: <20051230092449.GB5012@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20051222101523.GP27946@ftp.linux.org.uk> <20051223093146.GT27946@ftp.linux.org.uk> <20051223205108.GA15271@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223205108.GA15271@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 11:51:08PM +0300, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/pcmcia/cistpl.c |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Thanks, applied to the linux-pcmcia git tree, will push it into 2.6.16.

	Dominik
