Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVCXEi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVCXEi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbVCXEi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:38:58 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:397 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S263022AbVCXEim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:38:42 -0500
Date: Thu, 24 Mar 2005 14:38:38 +1000
From: David McCullough <davidm@snapgear.com>
To: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: ocf-linux-20050324 - Asynchronous Crypto support for linux
Message-ID: <20050324043838.GA3124@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

The latest release of ocf-linux (20050324) is available for download
from the project page:

  http://ocf-linux.sourceforge.net/

This release includes the following changes:

  * Added random number generator support for the hifn and safenet drivers.

  * Added patch for 2.4/2.6 kernels to allow RNG code to add entropy easily,
    implements add_true_randomness in both kernels.

  * First working version of the Public Key routines on the safenet.

  * Fixed a couple of nasty bugs in the existing key framework/driver support.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
