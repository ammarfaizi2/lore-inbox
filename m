Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbUKQLDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUKQLDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKQLDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:03:22 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:43948 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S262172AbUKQLDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:03:20 -0500
Date: Wed, 17 Nov 2004 12:03:17 +0100
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Ake <Ake.Sandgren@hpc2n.umu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Slab corruption with 2.6.9 + swsusp2.1
Message-ID: <20041117110317.GM26723@hpc2n.umu.se>
References: <20041116115917.GN4344@hpc2n.umu.se> <1100635759.4362.4.camel@desktop.cunninghams> <20041117064403.GB26723@hpc2n.umu.se> <1100688279.4040.4.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100688279.4040.4.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.6+20040722i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 09:44:40PM +1100, Nigel Cunningham wrote:
> Had you suspended prior to this? If not, you can rule the suspend code
> out. If you had, I wouldn't rule it out because I am trying to identify
> the cause of some occasional slab corruption at the moment. Haven't got
> it reproducible yet.

No, it was recently rebooted (4h 20min before) and no suspend.

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
