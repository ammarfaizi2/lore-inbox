Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUHACg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUHACg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 22:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHACg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 22:36:58 -0400
Received: from holomorphy.com ([207.189.100.168]:13988 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264900AbUHACg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 22:36:57 -0400
Date: Sat, 31 Jul 2004 19:36:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040801023655.GN2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 02:04:44AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm1/
[...]

There's trouble here with the link checking; it pukes all over
sparc32's btfixup stuff. Not entirely sure what the proper form of a
solution is.


-- wli
