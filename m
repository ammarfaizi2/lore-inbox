Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTE2LFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTE2LFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:05:32 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:9896 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262151AbTE2LFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:05:31 -0400
Date: Thu, 29 May 2003 12:20:57 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Christian <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IPv6 module oopsing on 2.5.69
Message-ID: <20030529112057.GA20425@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Christian <evil@g-house.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3ED5E9E7.5070602@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED5E9E7.5070602@g-house.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 01:07:19PM +0200, Christian wrote:

 > IPv6 support is not useable then, a single run of the "ping6" binary 
 > (even without options) gives a segfault. the machine is a Athlon 900,
 > running debian/testing (glibc 2.3.1), one tainted module (nvidia) 
 > loaded. more info available on demand.

repeatable without the binary stuff having ever been loaded at all?

		Dave


