Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSLBEEV>; Sun, 1 Dec 2002 23:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSLBEEV>; Sun, 1 Dec 2002 23:04:21 -0500
Received: from are.twiddle.net ([64.81.246.98]:2452 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264771AbSLBEEU>;
	Sun, 1 Dec 2002 23:04:20 -0500
Date: Sun, 1 Dec 2002 20:11:22 -0800
From: Richard Henderson <rth@twiddle.net>
To: Bjoern Brauel <bjb@gentoo.org>
Cc: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel build of 2.5.50 fails on Alpha
Message-ID: <20021201201122.A31609@twiddle.net>
Mail-Followup-To: Bjoern Brauel <bjb@gentoo.org>,
	Folkert van Heusden <folkert@vanheusden.com>,
	linux-kernel@vger.kernel.org
References: <000701c2994d$5ccee670$3640a8c0@boemboem> <3DEA3D39.7050806@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEA3D39.7050806@gentoo.org>; from bjb@gentoo.org on Sun, Dec 01, 2002 at 05:47:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 05:47:53PM +0100, Bjoern Brauel wrote:
> Ive been working on implementing some missing bits but what Id like to 
> know is who is "officially" doing development for alpha on 2.5.

See 

http://ftp.kernel.org/pub/linux/kernel/people/rusty/patches/Module/rth-shared-modules.patch.gz

which I hope will make it into the kernel relatively soon.


r~
