Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268589AbTBYWBg>; Tue, 25 Feb 2003 17:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268591AbTBYWBg>; Tue, 25 Feb 2003 17:01:36 -0500
Received: from holomorphy.com ([66.224.33.161]:64183 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268589AbTBYWBf>;
	Tue, 25 Feb 2003 17:01:35 -0500
Date: Tue, 25 Feb 2003 14:10:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, Chris Wedgwood <cw@f00f.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225221044.GH10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>, Chris Wedgwood <cw@f00f.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1046093309.1246.6.camel@irongate.swansea.linux.org.uk> <20030225051956.GA18302@f00f.org> <20030225052602.GW10411@holomorphy.com> <20030225212115.GB21870@f00f.org> <20030225212134.GD10411@holomorphy.com> <20030225220811.GA9317@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225220811.GA9317@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:21:34PM -0800, William Lee Irwin III wrote:
>> oprofile is what's needed. Looks like he's taking care of that too.

On Tue, Feb 25, 2003 at 02:08:11PM -0800, Larry McVoy wrote:
> Without doing something about the page coloring problem (and he might be)
> the numbers will be fairly meaningless.

Hmm, point. Let's see if we can get Cliff to apply the new patch that
one guy put out yesterday or so.


-- wli
