Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVCHNb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVCHNb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHNbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:31:55 -0500
Received: from users.linvision.com ([62.58.92.114]:57564 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262049AbVCHNbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:31:53 -0500
Date: Tue, 8 Mar 2005 14:31:49 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Vineet Joglekar <vintya@excite.com>
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: Random number generator in Linux kernel
Message-ID: <20050308133149.GC31844@harddisk-recovery.com>
References: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307231853.9F661B6E7@xprdmailfe20.nwk.excite.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 06:18:53PM -0500, Vineet Joglekar wrote:
> I want a function where I will be supplying a seed to that function
> as an input, and will get a random number back. If same seed is used,
> same number should be generated again.

Google for "Numerical recipes in C", it has a complete section about
random numbers, including a couple of functions that do what you want.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
