Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUDGVJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUDGVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:09:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20431 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264176AbUDGVJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:09:13 -0400
Date: Wed, 07 Apr 2004 14:19:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Eric Whiting <ewhiting@amis.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback
Message-ID: <68580000.1081372758@flay>
In-Reply-To: <20040405221641.GN2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Tuesday, April 06, 2004 00:16:41 +0200 Andrea Arcangeli <andrea@suse.de> wrote:

> On Mon, Apr 05, 2004 at 03:35:23PM -0600, Eric Whiting wrote:
>> 4G of virtual address is what we need. Virtual address space is why the -mmX
>> 4G/4G patches are useful. In this application it is single processes (usually
> 
> Indeed.
> 
>> 3.5:1.5 appears to be a 2.4.x kernel patch only right?
> 
> Martin has a port for 2.6 in the -mjb patchset (though it only works
> with PAE disabled but there are patches floating around to make it work
> at not noticeable cost with PAE enabled too).

There's no such thing as 3.5:1.5. Do you mean 3.5:0.5? or 2.5:1.5? ;-)

M.

