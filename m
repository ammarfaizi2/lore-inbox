Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268037AbTBNVGA>; Fri, 14 Feb 2003 16:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268143AbTBNVFd>; Fri, 14 Feb 2003 16:05:33 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:16892 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S268086AbTBNVEg>; Fri, 14 Feb 2003 16:04:36 -0500
Date: Fri, 14 Feb 2003 13:14:14 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Dax Kelson <dax@gurulabs.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: modutils that works with 2.4 and 2.5?
Message-ID: <20030214211414.GE30804@ca-server1.us.oracle.com>
References: <1045162343.1311.7.camel@mentor> <20030214060024.GC9578@actcom.co.il> <1045246324.1301.1.camel@mentor> <20030214182516.GG3632@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214182516.GG3632@actcom.co.il>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 08:25:16PM +0200, Muli Ben-Yehuda wrote:
> > Does it do this discovery at install time, or at each boot?
> 
> Each invocation, I suppose. Doesn't make much sense otherwise. 

	Each invocation.  Note that because Rusty's modutils replaces
insmod.static, it nicely breaks machines that use initrds.

Joel

-- 

"And yet I fight,
 And yet I fight this battle all alone.
 No one to cry to;
 No place to call home."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
