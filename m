Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbTCFXeP>; Thu, 6 Mar 2003 18:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbTCFXeL>; Thu, 6 Mar 2003 18:34:11 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:49909 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261287AbTCFXeG>; Thu, 6 Mar 2003 18:34:06 -0500
Date: Thu, 6 Mar 2003 15:44:28 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andreas Boman <aboman@midgaard.us>
Cc: Daniel Egger <degger@fhm.edu>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bloat 2.4 vs. 2.5
Message-ID: <20030306234428.GY2835@ca-server1.us.oracle.com>
References: <20030306142252.22630.qmail@linuxmail.org> <1046980273.18897.30.camel@sonja> <1046993653.30701.3.camel@asgaard.midgaard.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046993653.30701.3.camel@asgaard.midgaard.us>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 06:34:13PM -0500, Andreas Boman wrote:
> apt-get install module-init-tools, it will install 'right' and let you
> use modules with 2.4 and 2.5 kernels.

	As long as you don't use mkinitrd.  If you do, make sure you
keep around the 2.4 insmod.static in another directory to fix your
initrds.

Joel

-- 

Life's Little Instruction Book #267

	"Lie on your back and look at the stars."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
