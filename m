Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266374AbUAIBid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266392AbUAIBic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:38:32 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:23999 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266374AbUAIBhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:37:48 -0500
Date: Thu, 8 Jan 2004 17:37:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tim Cambrant <tim@cambrant.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cleanup patches - comparison is always [true|false] + unsigned/signed compare, and similar issues.   (consolidating existing threads)
Message-ID: <20040109013735.GU1882@matchmail.com>
Mail-Followup-To: Tim Cambrant <tim@cambrant.com>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.56.0401081847190.10083@jju_lnx.backbone.dif.dk> <20040108192539.GA11663@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108192539.GA11663@cambrant.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 08:25:39PM +0100, Tim Cambrant wrote:
> project like this is going down. Posting cleanup-patches once a week
> to LKML is probably not the way to go, since most of them will be
> ignored and/or flamed.

Use the trivial patch monkey for this, it will save you a lot of headache.
