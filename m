Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTJRV5f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTJRV5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:57:35 -0400
Received: from holomorphy.com ([66.224.33.161]:51852 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261861AbTJRV5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:57:34 -0400
Date: Sat, 18 Oct 2003 14:57:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Diego Calleja Garc?a <aradorlinux@yahoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-ID: <20031018215729.GK25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja Garc?a <aradorlinux@yahoo.es>,
	linux-kernel@vger.kernel.org
References: <20031018234848.51a2b723.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018234848.51a2b723.aradorlinux@yahoo.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 11:48:48PM +0200, Diego Calleja Garc?a wrote:
> Hi, I got some oops with test8; the first time I got it it was under
> test8-wli1; but it seems the same is happening under plain -test8.
> This is the original bug report:

Might be best to post the oops from mainline. I've made substantial
/proc/ changes, so they may not be related.


-- wli
