Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVKNSY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVKNSY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVKNSY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:24:27 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:33218 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751223AbVKNSY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:24:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ub1IvPKvNGeOiAMr48/nJ254EHvnhctgyX6YWoAB6WdgnupGew3KJBHPxAUTjaWYaTbWVpalUqQNaoXtb0vhiTGLj44wE1M3jSBoLXB+TmVnxKJJMAfDCONhXFiuUICSGLOifNr8qvq4TDSfDJ337vkEW8IbgNgfhp/geH+4h4w=
Message-ID: <84144f020511141024keb88e4dt520a80d99c4cc935@mail.gmail.com>
Date: Mon, 14 Nov 2005 20:24:25 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Subject: Re: Linuv 2.6.15-rc1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4378980C.7060901@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <4378980C.7060901@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 11/14/05, Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
> I experienced a hard crash (no input devices answering at all) yesterday
> while playing a movie from a CD, but with nothing showing up in
> /var/log/messages.

Please post your .config.

                              Pekka
