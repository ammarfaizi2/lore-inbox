Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUHFRn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUHFRn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUHFRko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:40:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:46496 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268182AbUHFR3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:29:51 -0400
Date: Fri, 06 Aug 2004 10:28:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Albert Cahalan <albert@users.sourceforge.net>,
       Roger Luethi <rl@hellgate.ch>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, wli@holomorphy.com
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <276140000.1091813324@flay>
In-Reply-To: <1091803883.1231.2502.camel@cube>
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <1091797122.1231.2452.camel@cube> <20040806163428.GA31285@k3.hellgate.ch> <1091803883.1231.2502.camel@cube>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, August 06, 2004 10:51:24 -0400 Albert Cahalan <albert@users.sourceforge.net> wrote:

> On Fri, 2004-08-06 at 12:34, Roger Luethi wrote:
>> On Fri, 06 Aug 2004 08:58:43 -0400, Albert Cahalan wrote:
>> > > Hardly. All I was asking this time was to have a documentation fix
>> > > merged, though.
>> > 
>> > Just delete the documentation. I certainly never use it.
>> 
>> It wasn't written for you.
> 
> OK, but the statm file was. (well, for the maintainer
> of procps a decade ago)
> 
> Everybody else can parse ps output.

I don't think that's necessarily a good idea - access to lower level
data would be nice. What's the harm in fixing the docs, anyway?

M.

