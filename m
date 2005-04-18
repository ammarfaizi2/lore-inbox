Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVDRTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVDRTym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDRTye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:54:34 -0400
Received: from pD95F37F7.dip.t-dialin.net ([217.95.55.247]:23715 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S262189AbVDRTyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:54:08 -0400
Date: Mon, 18 Apr 2005 19:53:51 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Rao Davide <davide.rao@atosorigin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Alpha port: LVM
Message-ID: <20050418195351.GA32124@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
	Rao Davide <davide.rao@atosorigin.com>,
	linux-kernel@vger.kernel.org
References: <42569BC7.5030709@atosorigin.com> <20050408190709.GB27845@twiddle.net> <425A2442.8090607@atosorigin.com> <4263ACA9.4080507@atosorigin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263ACA9.4080507@atosorigin.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 02:48:41PM +0200, Rao Davide wrote:
> Is LVM working on the alpha port 2.6 kernel series ?

works fine for me.

> If so where do I get libdevmapper so that I can build the userspace LVM 
> utils ?
> 
> I tryied downloading 
> ftp://sources.redhat.com/pub/dm/multipath-toolsmultipath-tools-0.4.3.tar.bz2

what do you think the 'dm' in that url stands for, hm?

> But I fail to compile it so I'm also unable tu build the userspace lvm 
> utils.

'userspace lvm utils' can be found here:

ftp://sources.redhat.com/pub/lvm2

multipath tools might be something different ... :)

> --
> Regards
> Davide Rao
>   Client/server Unix
>   Atos Origin
>   Via C.Viola - Pont St. Martin (AO) Italy
>   Cell :  +39 3357599151
>   Tel  :  +39 125810433
>   Email:  davide.rao@atosorigin.com


73 Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
