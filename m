Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVLGIVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVLGIVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 03:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVLGIVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 03:21:52 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:59050 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750712AbVLGIVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 03:21:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TEvVSEmxKM7bajqvpjRLmQc7fmCdMxPlRU1xtzBCx/mwv+CWllYIPXMqRS3Ql5NR5SohLNL2sc4qftxvHzI7QKrLufKKtdP3wTdBSv3dlKPJkMVmsurpHDByQAR5o7y7LFX3KNINRp0mpfolGC4Z8WBeRqm9iUtTQQ1eV6xV89I=
Message-ID: <84144f020512070021r38188044x54c0b2491ef4a176@mail.gmail.com>
Date: Wed, 7 Dec 2005 10:21:50 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
Cc: Al Viro <viro@ftp.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <17302.21437.608048.64857@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051206035220.097737000@localhost>
	 <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost>
	 <200512061949.33482.arnd@arndb.de> <1133895947.3279.4.camel@localhost>
	 <17301.65082.251692.675360@cargo.ozlabs.ibm.com>
	 <1133905298.8027.13.camel@localhost>
	 <17302.3696.364669.18755@cargo.ozlabs.ibm.com>
	 <20051207022610.GI27946@ftp.linux.org.uk>
	 <17302.21437.608048.64857@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 12/7/05, Paul Mackerras <paulus@samba.org> wrote:
> Could you review the spufs code (i.e. the patches posted by Arnd
> recently to linuxppc64-dev@ozlabs.org) please?

Why not post them to LKML?

                              Pekka
