Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281321AbRKVSK3>; Thu, 22 Nov 2001 13:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRKVSKT>; Thu, 22 Nov 2001 13:10:19 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:24325 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S281321AbRKVSKI>; Thu, 22 Nov 2001 13:10:08 -0500
Date: Thu, 22 Nov 2001 17:56:21 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Anton Petrusevich <casus@mail.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: is netfilter broken in 2.4.15-pre8?
In-Reply-To: <20011122111445.A9178@casus.tx>
Message-ID: <Pine.LNX.4.33.0111221755330.4394-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Anton Petrusevich wrote:

> I tried to use netfilter and was unable to do it. It can't resolve
> nf_[un]register_hook, nf_[un]register_sockopt and some others symbols.
> May be I did something wrong, here my .config goes:

Skip pre8 and go to pre9. I'll be testing it later tonight as I use
iptables on my sparc gateway box.

-- 
Broken hearted, but not down.

http://www.tahallah.demon.co.uk

