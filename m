Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264011AbTDNWSI (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTDNWSI (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:18:08 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:927 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S264011AbTDNWRk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:17:40 -0400
Date: Mon, 14 Apr 2003 15:28:47 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdevt-diff
Message-ID: <20030414222847.GN4917@ca-server1.us.oracle.com>
References: <UTC200304142201.h3EM19S07185.aeb@smtp.cwi.nl> <20030414221110.GK4917@ca-server1.us.oracle.com> <200304142218.h3EMIKIO017775@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142218.h3EMIKIO017775@turing-police.cc.vt.edu>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 06:18:20PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 14 Apr 2003 15:11:10 PDT, Joel Becker said:
> > 	I guess I'm wondering what made you choose "consistency across
> > legacy filesystems" over "consistency across our expanded device space".
> 
> I'm going to take a wild stab in the dark and say that being able to
> boot using the /dev on an iso9660 CD is a requirement for most distros?

	Um, most distros mount a ramdisk.  Also, the number of devices
needed for a boot surely fit in the 8:8 legacy space?  I'm willing to
hear dissent, I just wanted to know the rationale.

Joel

-- 

"The opposite of a correct statement is a false statement. The
 opposite of a profound truth may well be another profound truth."
         - Niels Bohr 

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
