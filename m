Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUASX4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUASX4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:56:54 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:60032 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263880AbUASX4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:56:51 -0500
Date: Mon, 19 Jan 2004 15:56:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ooops, linux 2.6.1
Message-ID: <20040119235640.GX1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Stian Jordet <liste@jordet.nu>,
	linux-kernel@vger.kernel.org
References: <1074555938.18661.2.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074555938.18661.2.camel@chevrolet.hybel>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:45:38AM +0100, Stian Jordet wrote:
> I don't know if anyone gets anything out of this. I tried running it
> through ksymoops, but got just weird results.
> 

No need, you have kallsyms turned on which does it for you.

> Hope someone sees what's going on here.
> 
> Best regards,
> Stian

What were you running at the time, and post your .config
