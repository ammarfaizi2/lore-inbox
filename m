Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUIXK0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUIXK0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUIXK0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:26:06 -0400
Received: from holomorphy.com ([207.189.100.168]:57566 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268665AbUIXK0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:26:04 -0400
Date: Fri, 24 Sep 2004 03:25:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Michal Rokos <michal@rokos.info>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040924102506.GB9106@holomorphy.com>
References: <20040924014643.484470b1.akpm@osdl.org> <4153EED2.1050508@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4153EED2.1050508@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> +natsemi-remove-compilation-warnings.patch
>> natsemi.c warning fixes

On Fri, Sep 24, 2004 at 07:54:26PM +1000, Nick Piggin wrote:
> My card fails to work unless this change is backed out.

Did you manage to boot successfully with the natsemi patch backed out?
If so, could I get a bootlog to compare against?


-- wli
