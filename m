Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265111AbUF1SNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUF1SNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUF1SNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:13:13 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28044 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265111AbUF1SNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:13:11 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Robert Picco <Robert.Picco@hp.com>
Subject: Re: [PATCH] ia64 kgdb
Date: Mon, 28 Jun 2004 11:13:01 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <40E05EF1.2070505@hp.com>
In-Reply-To: <40E05EF1.2070505@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406281113.01015.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 28, 2004 11:09 am, Robert Picco wrote:
> Hi Andrew:
>
> This fixes the broken kgdb patch.

Hey Bob, thanks for the patch.  Does the kgdb for ia64 require a special 
version of gdb or is the latest one from gnu.org sufficient?  And does it 
work with netconsole?

Thanks,
Jesse
