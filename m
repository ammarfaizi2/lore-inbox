Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUAXI0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 03:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266886AbUAXI0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 03:26:09 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:4874 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264481AbUAXI0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 03:26:08 -0500
Date: Sat, 24 Jan 2004 08:26:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bryan Whitehead <driver@megahappy.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nathans@sgi.com,
       owner-xfs@oss.sgi.com
Subject: Re: [PATCH 2.6.2-rc1-mm2] fs/xfs/xfs_log_recover.c
Message-ID: <20040124082606.A3107@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bryan Whitehead <driver@megahappy.net>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, nathans@sgi.com,
	owner-xfs@oss.sgi.com
References: <20040124073111.34B2313A354@mrhankey.megahappy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040124073111.34B2313A354@mrhankey.megahappy.net>; from driver@megahappy.net on Fri, Jan 23, 2004 at 11:31:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:31:11PM -0800, Bryan Whitehead wrote:
> 
> This fixes a warning on compile of the xfs fs module.

This patch looks very strange.  What error do you get without it?

