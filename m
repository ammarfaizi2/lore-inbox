Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTEHVfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTEHVfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:35:13 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:20492
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S262151AbTEHVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:35:11 -0400
Date: Thu, 8 May 2003 14:47:46 -0700
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HFS+ driver
Message-ID: <20030508214746.GB19450@pants.nu>
References: <Pine.LNX.4.44.0305071643030.5042-100000@serv> <20030508213401.GA3458@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508213401.GA3458@werewolf.able.es>
User-Agent: Mutt/1.3.28i
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 11:34:01PM +0200, J.A. Magallon wrote:
> How about this ?

Yes, this is a good patch. I originally started on 2.2.x, which
doesn't have strsep, and I didn't trust strtok (with good reason).
I'll get rid of my little hacked up function and use strsep instead.
Thanks for taking a look at the code.

	Brad Boyer
	flar@allandria.com

