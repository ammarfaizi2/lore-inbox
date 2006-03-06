Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWCFOOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWCFOOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 09:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWCFOOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 09:14:45 -0500
Received: from smtp17.wanadoo.fr ([193.252.23.111]:34647 "EHLO
	smtp17.wanadoo.fr") by vger.kernel.org with ESMTP id S932298AbWCFOOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 09:14:44 -0500
X-ME-UUID: 20060306141443103.19269700008D@mwinf1709.wanadoo.fr
Date: Mon, 6 Mar 2006 15:14:20 +0100
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060306141420.GA13739@localhost>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Al Viro <viro@ftp.linux.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru> <20060306130050.GI27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306130050.GI27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 01:00:50PM +0000, Al Viro wrote:
> FWIW, works here on DS10 and alphastation (both with SRM)...

Thanks for chiming in!!!

-- 
Mathieu Chouquet-Stringer

