Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132272AbRDAKxi>; Sun, 1 Apr 2001 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbRDAKx2>; Sun, 1 Apr 2001 06:53:28 -0400
Received: from anime.net ([63.172.78.150]:36366 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S132272AbRDAKxL>;
	Sun, 1 Apr 2001 06:53:11 -0400
Date: Sun, 1 Apr 2001 03:53:26 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Chip Salzenberg <chip@valinux.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: TCP Vegas implementation for Linux
In-Reply-To: <E14jfEW-0007bT-00@tytlal>
Message-ID: <Pine.LNX.4.30.0104010352230.28774-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Chip Salzenberg wrote:
> Our (VA's) kernel includes a Vegas patch:
>    ftp://ftp.valinux.com/pub/people/chip/linux-vegas-v2-patch-2.2

tcp vegas performs very badly for me on asymmetric links (e.g. adsl),
about 50% performance loss vs non-vegas.

-Dan

