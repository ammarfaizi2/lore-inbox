Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRKUBpD>; Tue, 20 Nov 2001 20:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281144AbRKUBox>; Tue, 20 Nov 2001 20:44:53 -0500
Received: from 213-145-163-12.dd.nextgentel.com ([213.145.163.12]:47734 "EHLO
	athlon.kvaalen.no") by vger.kernel.org with ESMTP
	id <S281129AbRKUBos> convert rfc822-to-8bit; Tue, 20 Nov 2001 20:44:48 -0500
To: "Dan Maas" <dmaas@dcine.com>
Cc: "Rik van Riel" <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <Pine.LNX.4.33L.0111202019170.4079-100000@imladris.surriel.com> <03bb01c17213$887ccd30$1a01a8c0@allyourbase>
From: "=?iso-8859-1?q?H=E5vard_Kv=E5len?=" <havardk@netcom.no>
Date: 21 Nov 2001 02:45:23 +0100
In-Reply-To: <fa.jc73ejv.1s6e80t@ifi.uio.no>
Message-ID: <m3wv0knbgs.fsf@athlon.kvaalen.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (I just tried looking at XMMS and Freeamp - I *think* they are using
> read(), but strace seems to do bad things with threaded programs,
> argh...)

You are right about XMMS, it uses read().  I'm not sure about Freeamp.

-- 
Håvard Kvålen
