Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUDUNTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUDUNTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 09:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUDUNTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 09:19:08 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:36102 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261875AbUDUNTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 09:19:06 -0400
Date: Wed, 21 Apr 2004 14:19:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040421141901.B5551@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, raven@themaw.net,
	Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org> <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au> <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org> <Pine.LNX.4.58.0404212035280.3740@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404212035280.3740@donald.themaw.net>; from raven@themaw.net on Wed, Apr 21, 2004 at 08:39:59PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:39:59PM +0800, raven@themaw.net wrote:
> While I understand the motive for not exporting the lock the question of 
> how one should obtain vfsmount structs when needed remains?

You shouldn't.

