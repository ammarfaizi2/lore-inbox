Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVLMTQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVLMTQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVLMTQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:16:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:39577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932259AbVLMTQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:16:11 -0500
Date: Tue, 13 Dec 2005 10:12:53 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       r3pek@gentoo.org, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 09/26] DVB: BUDGET CI card depends on STV0297 demodulator
Message-ID: <20051213181253.GB12947@kroah.com>
References: <20051213073430.558435000@press.kroah.org> <20051213082242.GJ5823@kroah.com> <439EEDD4.9030909@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439EEDD4.9030909@gentoo.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 03:50:44PM +0000, Daniel Drake wrote:
> Greg KH wrote:
> >-stable review patch.  If anyone has any objections, please let us know.
> >
> >------------------
> >From: Daniel Drake <dsd@gentoo.org>
> >
> >This patch solves a DVB driver compile error introduced in 2.6.14
> >
> >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Sorry, I accidently dropped the headers when submitting this.  The correct 
> headers are as below:

I've updated the headers, thanks for letting us know.

greg k-h
