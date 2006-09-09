Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWIISFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWIISFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWIISFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 14:05:04 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:21598 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964790AbWIISFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 14:05:00 -0400
Message-ID: <45030245.9080005@tls.msk.ru>
Date: Sat, 09 Sep 2006 22:04:53 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "jens m. noedler" <noedler@web.de>
CC: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH -rc6] [resend] Documentation/ABI: devfs is not obsolete,
 but removed!
References: <4502F7A9.70200@web.de>
In-Reply-To: <4502F7A9.70200@web.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jens m. noedler wrote:
> Hi everybody, Greg, Linus,
> 
> This little patch just moves the devfs entry from ABI/obsolete to
> ABI/removed and adds the comment, that devfs was removed in 2.6.18.
> 
[]
> +	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
> +	along with the the assorted devfs function calls throughout the
> +	kernel tree.

So, will the files be removed at some point, or has them been removed
already? :)

/mjt
