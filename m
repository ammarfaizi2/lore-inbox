Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272224AbTHIBDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272167AbTHIBDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:03:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24080
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272163AbTHIBDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:03:18 -0400
Date: Fri, 8 Aug 2003 18:03:15 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1
Message-ID: <20030809010315.GB1027@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030727233716.56fb68d2.akpm@osdl.org> <20030809002817.GA1027@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809002817.GA1027@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[killing linux-mm in CC]

On Fri, Aug 08, 2003 at 05:28:17PM -0700, Mike Fedyk wrote:
> Though it was interesting that there weren't any errors reported from the
> 2.6 nfs server.

Ok, the 2.6 client is having trouble with the 2.6 server also, so that
wasn't anything special then.

I have some tcpdump traces from one of the nfs servers that shows the pauses
that are happening in the transmission if anyone would like to take a look.

I'm not sure what else I can do to find out why it is pausing.

Any ideas?
