Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTIEBI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbTIEBI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:08:28 -0400
Received: from vitelus.com ([64.81.243.207]:60113 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261941AbTIEBI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:08:26 -0400
Date: Thu, 4 Sep 2003 18:05:35 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905010535.GV2743@vitelus.com>
References: <20030905004710.GA31000@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905004710.GA31000@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 02:47:10AM +0200, Andi Kleen wrote:
> 
> Hallo,
> 
> gcc 3.4 current has switched to default -fno-unit-at-a-time mode for -O2. 
> The 3.3-Hammer branch compiler used in some distributions also does this.
> 
> Unfortunately the kernel doesn't compile with unit-at-a-time currently,

Did you mean -funit-at-a-time, rather than the converse?
