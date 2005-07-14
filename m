Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVGNWcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVGNWcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVGNW3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:29:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:60606 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262855AbVGNW1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:27:51 -0400
Date: Fri, 15 Jul 2005 00:27:48 +0200
From: Andi Kleen <ak@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [announce] linux kernel performance project launch at sourceforge.net
Message-ID: <20050714222748.GN23737@wotan.suse.de>
References: <p73y889kp5w.fsf@bragg.suse.de> <200507142224.j6EMOjg06251@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507142224.j6EMOjg06251@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Some oprofile listings from a few of the test runs would be also nice.
> 
> That is in the works.  We will upload profile data.  I'm having problem
> with oprofile on some versions of kernel and that is being investigated
> right now.

If you run statically compiled kernels you could as well use the
old style readprofile.  It just doesn't work with modules.

-Andi
