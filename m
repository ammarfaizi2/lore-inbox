Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319543AbSIGXnL>; Sat, 7 Sep 2002 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319544AbSIGXnL>; Sat, 7 Sep 2002 19:43:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53428 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319543AbSIGXnL>; Sat, 7 Sep 2002 19:43:11 -0400
Date: Sat, 07 Sep 2002 16:44:27 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>
cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <2090000.1031442267@flay>
In-Reply-To: <3D7A87F1.F3D0865C@digeo.com>
References: <20020907121854.10290.qmail@linuxmail.org> <3D7A2768.E5C85EB@digeo.com> <20020907200334.GI888@holomorphy.com> <3D7A87F1.F3D0865C@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Perhaps testing with overcommit on would be useful.
> 
> Well yes - the new overcommit code was a significant hit on the 16ways
> was it not?  You have some numbers on that?

About 20% hit on system time for kernel compiles.

M.

