Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTHZOcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTHZOb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:31:59 -0400
Received: from holomorphy.com ([66.224.33.161]:37295 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261461AbTHZObq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:31:46 -0400
Date: Tue, 26 Aug 2003 07:32:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1
Message-ID: <20030826143252.GT4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030824171318.4acf1182.akpm@osdl.org> <30190000.1061853042@flay> <20030826100824.GQ4306@holomorphy.com> <9910000.1061907789@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9910000.1061907789@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote (on Tuesday, August 26, 2003 03:08:24 -0700):
>> Hmm, seeing functions I wrote in diffprofiles like this gives me the
>> wli's. Any chance you could snapshot /proc/slabinfo say every 1s during
>> a run so I can see what's going on?

On Tue, Aug 26, 2003 at 07:23:10AM -0700, Martin J. Bligh wrote:
> You should be able to recreate this easily yourself, but on closer
> inspection, it seems the cost is just shifted from pgd_ctor.

That's a big relief.

Thanks.


-- wli
