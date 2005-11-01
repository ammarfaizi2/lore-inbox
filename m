Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVKAAYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVKAAYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVKAAYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:24:40 -0500
Received: from ozlabs.org ([203.10.76.45]:15232 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964921AbVKAAYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:24:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.46523.698248.169639@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 11:24:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/20] inflate: lindent and manual formatting changes
In-Reply-To: <2.196662837@selenic.com>
References: <2.196662837@selenic.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt,

My concern about this series of patches is that it will make it harder
to keep the kernel zlib in sync with the upstream zlib.

Are you signing up to track the upstream zlib and apply any changes
made there to the kernel version, for the forseeable future?

Paul.
