Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752893AbWKIHag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbWKIHag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbWKIHag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:30:36 -0500
Received: from colin.muc.de ([193.149.48.1]:23812 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1752891AbWKIHag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:30:36 -0500
Date: 9 Nov 2006 08:30:34 +0100
Date: Thu, 9 Nov 2006 08:30:34 +0100
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH][2.6.19-rc5-mm1] i386: Convert more absolute symbols to section relative
Message-ID: <20061109073034.GA11760@muc.de>
References: <20061108221621.GB29705@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108221621.GB29705@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 05:16:21PM -0500, Vivek Goyal wrote:
> 
> 
> o Convert more absolute symbols to section relative to keep the theme in
>   vmlinux.lds.S file and to avoid problem if kernel is relocated.
> 
> o Also put a message so that in future people can be aware of it and 
>   avoid introducing absolute symbols.

Added thanks

-Andi
