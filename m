Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWJLNop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWJLNop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWJLNop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 09:44:45 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:29448 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751404AbWJLNoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 09:44:44 -0400
Date: Thu, 12 Oct 2006 09:41:31 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>
Subject: Re: [patch 11/67] zd1211rw: ZD1211B ASIC/FWT, not jointly decoder
Message-ID: <20061012134118.GB29154@tuxdriver.com>
References: <20061011204756.642936754@quad.kroah.org> <20061011210412.GL16627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011210412.GL16627@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 02:04:12PM -0700, Greg KH wrote:
> 
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Daniel Drake <dsd@gentoo.org>
> 
> The vendor driver chooses this value based on an ifndef ASIC,
> and ASIC is never defined.

ACK

-- 
John W. Linville
linville@tuxdriver.com
