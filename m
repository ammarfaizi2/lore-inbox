Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTEKNod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 09:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTEKNoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 09:44:32 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:24073 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261405AbTEKNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 09:44:29 -0400
Date: Sun, 11 May 2003 14:56:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21-rc2: agpgart_be.c errors
Message-ID: <20030511145648.C20017@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kristian Peters <kristian.peters@korseby.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030511150527.5366d9bb.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030511150527.5366d9bb.kristian.peters@korseby.net>; from kristian.peters@korseby.net on Sun, May 11, 2003 at 03:05:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 03:05:27PM +0200, Kristian Peters wrote:
> Hello.
> 
> Under powerpc I've got:

Linux 2.4 mainline doesn't support AGP on ppc.

