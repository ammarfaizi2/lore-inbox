Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVF3Bdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVF3Bdr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 21:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVF3Bdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 21:33:47 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:64688 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S262679AbVF3Bdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 21:33:44 -0400
Date: Wed, 29 Jun 2005 18:30:11 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] [-mm patch] CONFIGFS_FS: "If unsure, say N."
Message-ID: <20050630013011.GF23823@ca-server1.us.oracle.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, ocfs2-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
References: <20050624080315.GC26545@stusta.de> <20050629213038.GA23823@ca-server1.us.oracle.com> <20050630004738.GA27478@stusta.de> <20050630005723.GE23823@ca-server1.us.oracle.com> <20050630011015.GC27478@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630011015.GC27478@stusta.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 03:10:15AM +0200, Adrian Bunk wrote:
> The question is:
> Assume a user doesn't use external modules, will enabling this option 
> have any effect for him except that it wastes some bytes of his RAM?
> 
> sysfs is useful in this case.
> How is configfs useful in this case?

	I'm not saying it is.  I'm saying that "Hey, if you are unsure
you want 'N'" is a good thing to say, but removing the description of
"what configfs is" is unhelpful and unneeded.

Joel

-- 

"And yet I fight,
 And yet I fight this battle all alone.
 No one to cry to;
 No place to call home."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
