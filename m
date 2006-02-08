Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWBHKJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWBHKJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBHKJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:09:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:134 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932116AbWBHKJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:09:01 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060208064905.310066000@sorel.sous-sol.org> 
References: <20060208064905.310066000@sorel.sous-sol.org>  <20060208064503.924238000@sorel.sous-sol.org> 
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dhowells@redhat.com,
       davi.arnaut@gmail.com
Subject: Re: [PATCH 13/23] Fix keyctl usage of strnlen_user() 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 08 Feb 2006 10:07:38 +0000
Message-ID: <1714.1139393258@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> wrote:

> -stable review patch.  If anyone has any objections, please let us know.

It looks fine by me.

David
