Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285318AbRLXUor>; Mon, 24 Dec 2001 15:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285317AbRLXUo1>; Mon, 24 Dec 2001 15:44:27 -0500
Received: from Makaera.com ([199.202.113.33]:2055 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id <S285316AbRLXUoS>;
	Mon, 24 Dec 2001 15:44:18 -0500
Date: Mon, 24 Dec 2001 15:44:17 -0500
From: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011224154417.A24841@Sophia.soo.com>
In-Reply-To: <20011223144800.A22538@Sophia.soo.com> <Pine.LNX.4.33.0112231457070.5312-100000@coffee.psychology.mcmaster.ca> <20011223160419.A22752@Sophia.soo.com> <20011224150340.B593@suse.de> <20011224153635.A24786@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011224153635.A24786@Sophia.soo.com>; from lnx-kern@Sophia.soo.com on Mon, Dec 24, 2001 at 03:36:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also, i'm using gcc 3.0.3, binutils 2.11.2.
Hm.  And Glibc 2.2.4 , X 4.1.0 with GATO patches
for the rage128 driver, and sawfish 1.0.1.

b

On Mon, Dec 24, 2001 at 03:36:35PM -0500, really mason_at_soo_dot_com wrote:
> ok, with this patch X still exhibits the same behavior,
> minus the above error message in .xsession-errors!
> 
> Nothing in dmesg, no kernel messages, no oopsen.
