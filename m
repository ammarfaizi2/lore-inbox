Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTA1QWJ>; Tue, 28 Jan 2003 11:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTA1QWJ>; Tue, 28 Jan 2003 11:22:09 -0500
Received: from are.twiddle.net ([64.81.246.98]:41604 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267354AbTA1QWI>;
	Tue, 28 Jan 2003 11:22:08 -0500
Date: Tue, 28 Jan 2003 08:31:17 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] new modversions implementation
Message-ID: <20030128083117.A15637@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu> <20030128104035.68A742C2DC@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030128104035.68A742C2DC@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Jan 28, 2003 at 09:38:31PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 09:38:31PM +1100, Rusty Russell wrote:
> 	But once again you are relying on link order to keep the crcs
> section in the same order as the ksymtab section (although the ld
> documentation says that's correct, I know RTH doesn't like it).

What gave you that idea?  Link order is a fine thing to rely on.


r~
