Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTL2DGt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTL2DGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:06:49 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:55182 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262540AbTL2DGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:06:48 -0500
Date: Sun, 28 Dec 2003 19:06:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: akmiller@nzol.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide: "lost interrupt" with 2.6.0
Message-ID: <20031229030639.GF1882@matchmail.com>
Mail-Followup-To: akmiller@nzol.net, linux-kernel@vger.kernel.org
References: <1072661969.3fef85d204077@webmail.nzol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072661969.3fef85d204077@webmail.nzol.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 02:39:30PM +1300, akmiller@nzol.net wrote:
> It also doesn't work correctly with the Linux 2.4.20(using the installation
> kernel off the RedHat 9 disk). It is confirmed to work with 2.4.2, as well as
> with the 2.2.x series.

Try narrowing down where in the 2.4 series the problem started, and use only
stock (kernel.org) kernels as dist kernels (redhat, etc.) since the dist
kernels have many patches that modify the behaviour of the kernel.

Do you have trouble with:

2.4.18?

2.4.20?

2.4.22?
