Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbUKQLdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUKQLdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUKQLdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:33:23 -0500
Received: from holomorphy.com ([207.189.100.168]:64454 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262273AbUKQLcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:32:35 -0500
Date: Wed, 17 Nov 2004 03:32:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1
Message-ID: <20041117113225.GP3217@holomorphy.com>
References: <20041116014213.2128aca9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116014213.2128aca9.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 01:42:13AM -0800, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.10-rc2-mm1.gz
> will appear soon at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/
> - Various little fixes and features.  Nothing major here.

Dies at boot on sparc64 repeatedly printk'ing some PROMLIB message.
Hunting for the offending patch...


-- wli
