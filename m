Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVBDK7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVBDK7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVBDK7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:59:47 -0500
Received: from sd291.sivit.org ([194.146.225.122]:15506 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262359AbVBDK7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:59:43 -0500
Date: Fri, 4 Feb 2005 11:59:42 +0100
From: Stelian Pop <stelian@popies.net>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204105942.GC29712@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	linux-kernel@vger.kernel.org
References: <20050202155403.GE3117@crusoe.alcove-fr> <20050204101827.GA13455@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204101827.GA13455@mellanox.co.il>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 12:18:27PM +0200, Michael S. Tsirkin wrote:

> 
> Hi, Stelian!
> One thing everyone creating kernel patches with subversion
> must be aware of, is the fact that the subversion built-in diff command does
> not understand the gnu diff -p flag (or indeed, any gnu diff flags at all,
> with the exception of -u, which is the default anyway).

There is a section called "How do I generate 'proper' diffs ?" dealing
with this.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
