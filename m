Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266165AbUFIP4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUFIP4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUFIP4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:56:04 -0400
Received: from holomorphy.com ([207.189.100.168]:21125 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266165AbUFIP4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:56:00 -0400
Date: Wed, 9 Jun 2004 08:50:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric BEGOT <eric_begot@yahoo.fr>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609155055.GO1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eric BEGOT <eric_begot@yahoo.fr>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040609015001.31d249ca.akpm@osdl.org> <40C6F3C3.9040401@yahoo.fr> <Pine.LNX.4.58.0406090910170.1838@montezuma.fsmlabs.com> <20040609133653.GH1444@holomorphy.com> <Pine.LNX.4.58.0406090942420.1838@montezuma.fsmlabs.com> <20040609144809.GK1444@holomorphy.com> <20040609145849.GL1444@holomorphy.com> <40C73198.4080700@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C73198.4080700@yahoo.fr>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Actually I think blowing it away immediately is best. Bounds checks
>> don't work for everything.


On Wed, Jun 09, 2004 at 05:49:44PM +0200, Eric BEGOT wrote:
> Ok I applied the two patches and i works now. I have a 2.6.7-rc3-mm1. I 
> attached the two patches.
> Thx william.

Thank you very much for testing and being patient with the programming
errors of mine present in stock 2.6.7-rc3-mm1.

akpm, could you please apply the two fixes I sent Eric?

Thanks.


-- wli
