Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUHQHGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUHQHGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUHQHGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:06:21 -0400
Received: from holomorphy.com ([207.189.100.168]:15533 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268131AbUHQHFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:05:51 -0400
Date: Tue, 17 Aug 2004 00:05:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sam Ravnborg <sam@ravnborg.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817070544.GN11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Nathan Lynch <nathanl@austin.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <121120000.1092699569@flay> <1092706344.3081.4.camel@booger> <20040817065901.GB7173@mars.ravnborg.org> <20040817070011.GM11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817070011.GM11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 08:32:24PM -0500, Nathan Lynch wrote:
>>> I hit the same thing on ppc64 with gcc 3.3.2-ish.  Doing a non-parallel
>>> make (i.e. without -j) seems to work around it for me.

On Tue, Aug 17, 2004 at 08:59:01AM +0200, Sam Ravnborg wrote:
>> Fix below:
>
On Tue, Aug 17, 2004 at 12:00:11AM -0700, William Lee Irwin III wrote:
> The result of this appears to be:

Never mind, the semicolon was essential.


-- wli
