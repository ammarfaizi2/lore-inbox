Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUEZUI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUEZUI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUEZUI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:08:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265782AbUEZUI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:08:56 -0400
Date: Wed, 26 May 2004 16:08:51 -0400
From: Alan Cox <alan@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: was Re: VIA "Velocity" Gigabit ethernet driver
Message-ID: <20040526200851.GB7433@devserv.devel.redhat.com>
References: <20040526174018.GA29119@devserv.devel.redhat.com> <20040526113000.09ccc390.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526113000.09ccc390.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 11:30:00AM -0700, David S. Miller wrote:
> > It should work on both 32 and 64bit little endian, it won't work on big
> > endian boxes yet.
> 
> 64-bit eh? :-)

Works on athlon64 .. will apply 
