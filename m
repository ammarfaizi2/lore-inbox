Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311599AbSCNMaD>; Thu, 14 Mar 2002 07:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311601AbSCNM3x>; Thu, 14 Mar 2002 07:29:53 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:41778 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311599AbSCNM3r>;
	Thu, 14 Mar 2002 07:29:47 -0500
Date: Thu, 14 Mar 2002 12:33:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gerd Knorr <kraxel@bytesex.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel List <linux-kernel@vger.kernel.org>, <arjan@fenrus.demon.nl>
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
In-Reply-To: <Pine.LNX.4.33.0203141219180.1643-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0203141232140.1643-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Tigran Aivazian wrote:
> (note, that despite me writing this email as @veritas.com we don't
> actually need this symbol to be _GPL but if I believe something is not

me switching "yes" and "no" again. I meant "we don't need this to be
_without_ _GPL", i.e. we are happy either way. It just doesn't seem right,
that is all.

