Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUBNBXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 20:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbUBNBXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 20:23:40 -0500
Received: from mail.shareable.org ([81.29.64.88]:64642 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264534AbUBNBWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 20:22:47 -0500
Date: Sat, 14 Feb 2004 01:22:42 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: RANDAZZO@ddc-web.com, linux-kernel@vger.kernel.org
Subject: Re: FW: spinlocks dont work
Message-ID: <20040214012242.GE31199@mail.shareable.org>
References: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD> <402D528E.5070105@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402D528E.5070105@quark.didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> On UP, spinlocks are no-ops.

No they aren't.  They disable preemption.

-- Jamie
