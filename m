Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbTD3JZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 05:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTD3JZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 05:25:45 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:1549 "HELO mail.truemesh.com")
	by vger.kernel.org with SMTP id S262007AbTD3JZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 05:25:44 -0400
Date: Wed, 30 Apr 2003 10:43:07 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Yang-Hwee TAN <tanyh@bii-sg.org>
Cc: venom@sns.it, linux-kernel@vger.kernel.org
Subject: Re: RHAS kernel upgrade?
Message-ID: <20030430094306.GO17378@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Yang-Hwee TAN <tanyh@bii-sg.org>, venom@sns.it,
	linux-kernel@vger.kernel.org
References: <1188.192.168.122.46.1051694168.squirrel@web.bii.a-star.edu.sg> <Pine.LNX.4.43.0304301125360.5028-100000@cibs9.sns.it> <1209.192.168.122.46.1051695018.squirrel@web.bii.a-star.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1209.192.168.122.46.1051695018.squirrel@web.bii.a-star.edu.sg>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 05:30:18PM +0800, Yang-Hwee TAN wrote:
> looking at the rhas kernel src rpm, there's alot of patches
> made into the kernel, i'm not sure if i use the plain vanilla
> kernel tarball would i disable some kernel options and
> "cripple" any of the RH's advance server's functionality(s).
> 
> has anyone use RHAS in a cluster environment with manual
> upgrading of kernel to perhaps 2.4.20, and everything goes
> well on the AS functionalities/add-ons?

I've noticed this kicking about on people.redhat.com, which contains
patches and configs against 2.4.20 so you can brew a 2.4.20 rpm.

http://people.redhat.com/laroche/kernel-2.4.20-2.1.23.ent.src.rpm.tar.gz

It may provide a useful starting point to work out what you want to add
to 2.4.20 for RHAS, however I haven't used this in a production
environment so usual disclaimers apply :)

Paul
