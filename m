Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbSJQEqL>; Thu, 17 Oct 2002 00:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261787AbSJQEqL>; Thu, 17 Oct 2002 00:46:11 -0400
Received: from are.twiddle.net ([64.81.246.98]:37812 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261786AbSJQEqL>;
	Thu, 17 Oct 2002 00:46:11 -0400
Date: Wed, 16 Oct 2002 21:52:06 -0700
From: Richard Henderson <rth@twiddle.net>
To: Aravind Ceyardass <aravind1001@speedpost.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gcc and regparm
Message-ID: <20021016215206.A19262@twiddle.net>
Mail-Followup-To: Aravind Ceyardass <aravind1001@speedpost.net>,
	linux-kernel@vger.kernel.org
References: <20021016174248.C34811AEC146@server5.fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021016174248.C34811AEC146@server5.fastmail.fm>; from aravind1001@speedpost.net on Wed, Oct 16, 2002 at 05:42:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 05:42:48PM +0000, Aravind Ceyardass wrote:
> Gcc 3.2 doesn't honours the regparm attribute for FASTCALL in
> asm-i386/linkage.h

I don't believe you.  Test case?


r~
