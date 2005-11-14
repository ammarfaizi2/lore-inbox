Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVKNSZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVKNSZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVKNSZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:25:15 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:14344 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751225AbVKNSZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:25:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cbi7Rtm0XN7nF/Ovl0EdQsSthhP0hJovXvYOb6RvfvqvLqT//3mDdSMTqhODwGX0BtPKhcqBDg6EmkdB1s1H2qhSVgnjx5fgY+9la9HvJFr9BAEl5Dl7TSKJxoMGLPuldXMDdr51e6X5oHyB9+7YAm3Y+iwr2QMohFmtdgHkauk=
Message-ID: <84144f020511141025h7e6bacdbs20101616d0bc74fe@mail.gmail.com>
Date: Mon, 14 Nov 2005 20:25:12 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: Linuv 2.6.15-rc1
Cc: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051114143248.GA3859@gemtek.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <4378980C.7060901@ens-lyon.fr> <20051114143248.GA3859@gemtek.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zilvinas,

On 11/14/05, Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> the same problem is present with 2.6.14 + ipw2200 1.0.8/ieee80211 1.1.6
> too. I didn't report problem as I am using madwifi drivers (which
> taints the kernel) and thought it was related to madwifi CVS (latest)
> and the newest ipw2200 drivers.

Please post your .config.

                             Pekka
