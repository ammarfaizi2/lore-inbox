Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUAGRj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266260AbUAGRj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:39:28 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:8329 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266259AbUAGRjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:39:25 -0500
Date: Wed, 7 Jan 2004 09:38:53 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Eric Hustvedt <lkml@plumlocosoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24-ck1
Message-ID: <20040107173853.GI1882@matchmail.com>
Mail-Followup-To: Eric Hustvedt <lkml@plumlocosoft.com>,
	linux-kernel@vger.kernel.org
References: <1073462109.1734.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073462109.1734.16.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 02:55:09AM -0500, Eric Hustvedt wrote:
> - Support for non-x86 architectures. I figure that I will need to
> backport the low-level support for the O1 scheduler. If anyone can point
> me towards existing patches, that would be very appreciated.

O(1) is also in -aa and wolk, so maybe they have code helpful for this...
