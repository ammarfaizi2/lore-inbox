Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVF3BBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVF3BBC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 21:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVF3BBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 21:01:02 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:17275 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262768AbVF3BA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 21:00:57 -0400
Date: Wed, 29 Jun 2005 17:57:23 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] [-mm patch] CONFIGFS_FS: "If unsure, say N."
Message-ID: <20050630005723.GE23823@ca-server1.us.oracle.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, ocfs2-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
References: <20050624080315.GC26545@stusta.de> <20050629213038.GA23823@ca-server1.us.oracle.com> <20050630004738.GA27478@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630004738.GA27478@stusta.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 02:47:38AM +0200, Adrian Bunk wrote:
> But I get your point, what about the patch below?

	Non-descriptive.  We are descriptive for sysfs (and even allow
the choice!).  I'd say that leaving the description but perhaps adding
the caveat about modules and unsure-N might be a good way to go.

Joel

-- 

"If you are ever in doubt as to whether or not to kiss a pretty girl, 
 give her the benefit of the doubt"
                                        -Thomas Carlyle

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
