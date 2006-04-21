Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWDUFTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWDUFTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 01:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDUFTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 01:19:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:703 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932253AbWDUFTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 01:19:08 -0400
Date: Fri, 21 Apr 2006 01:19:04 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove dead s390 prototype.
Message-ID: <20060421051904.GB17797@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060421045433.GA30407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421045433.GA30407@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 11:54:33PM -0500, Dave Jones wrote:
 > drivers/s390/crypto/z90main.c:367: warning: 'z90crypt_compat_ioctl' declared 'static' but never defined
 > 
 > Signed-off-by: Dave Jones <davej@redhat.com>

ignore this, it's bogus. (I didn't have CONFIG_COMPAT enabled, and fudged my grep)

		Dave

-- 
http://www.codemonkey.org.uk
