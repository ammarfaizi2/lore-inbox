Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268102AbUIGO0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbUIGO0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUIGO0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:26:50 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:45456 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S268102AbUIGO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:26:46 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Joris Neujens <joris@discosmash.com>
Subject: Re: Possible network issue in 2.6.8.1
Date: Tue, 7 Sep 2004 16:29:27 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
In-Reply-To: <Pine.LNX.4.58.0409071544570.6867@asus.discosmash.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409071629.27814.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 15:55, Joris Neujens wrote:
> Hello,
> 
> We've got a weird problem at our university network.  Since we upgraded to
> kernel 2.6.8 our download rate never gets higher than 10kB/sec.  Upload
> remains at original rate.  This problem does not occur with previous
> kernels (works fine again after downgrading to 2.6.7, without changing
> anything at the kernel config).
> 
> There are no speed issues when transfering on the LAN, only when
> downloading something from the internet
> 
> We have ruled out the following:
> Network source is slow (we were testing with the same FTP server all the
> time, from which we normally download at 10MB/sec)
> We tested with 3 different systems and network cards, and they all have
> the same problem, and only with kernel 2.6.8
> 
> any thoughts?

http://lwn.net/Articles/92727/

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)
