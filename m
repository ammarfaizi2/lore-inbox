Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTEPR4H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTEPR4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:56:07 -0400
Received: from holomorphy.com ([66.224.33.161]:16855 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264508AbTEPR4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:56:06 -0400
Date: Fri, 16 May 2003 11:08:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [OOPS] 2.5.69-mm6
Message-ID: <20030516180848.GW8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030516015407.2768b570.akpm@digeo.com> <87fznfku8z.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fznfku8z.fsf@lapper.ihatent.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 01:26:20PM +0200, Alexander Hoogerhuis wrote:
> This one goes in -mm5 as well, machine runs fine for a while in X, but
> trying to switch to a vty send the machine into the tall weeds...

Could you run with the radeon driver non-modular and kernel debugging
on? Then when it oopses could you use addr2line(1) to resolve this to
a line number?

I'm at something of a loss with respect to dealing with DRM in general.


Thanks.


-- wli
