Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTDDWn3 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbTDDWn3 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:43:29 -0500
Received: from lsanca2-ar27-4-46-141-054.lsanca2.dsl-verizon.net ([4.46.141.54]:41344
	"EHLO BL4ST") by vger.kernel.org with ESMTP id S261387AbTDDWn2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 17:43:28 -0500
Date: Fri, 4 Apr 2003 14:54:58 -0800
From: Eric Wong <eric@yhbt.net>
To: Brent Clements <bclem@rice.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Updates list of 2.4.20 patches
Message-ID: <20030404225458.GB30530@BL4ST>
References: <1049380771.3551.9.camel@batman.ece.rice.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049380771.3551.9.camel@batman.ece.rice.edu>
Organization: Tire Smokers Anonymous
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Clements <bclem@rice.edu> wrote:
> Is there a list somewhere(with ability to download) of all of the
> patches to 2.4.20 that people have applied or suggested?
> 
> I don't want to move my production system to 2.4.21-preX but I do want
> to make sure I've kept 2.4.20 up-to-date.

For 2.4.20, I use the kernel sources in the Debian unstable archive,
currently in it's 6th release for 2.4.20.  It has the ptrace, ext3, and
padding fixes from 2.4.21preX, and some other bug-fix only things. 

-- 
Eric Wong
