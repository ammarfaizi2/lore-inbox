Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTJWSon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJWSon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:44:43 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:58123 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S261639AbTJWSom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:44:42 -0400
Date: Thu, 23 Oct 2003 20:44:36 +0200
From: David Jez <dave.jez@seznam.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: diethotplug-0.4 utility patch
Message-ID: <20031023184430.GA80427@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Greg,

  I send you patch for diethotplug-0.4, witch:
- adds remove action
- adds pci.rc & usb.rc
- usb.rc script remove modules not by fixed list as hotplug, but from
  list gotten from depend files when compiled
- for USB: matching by vendor & class, not only by vendor (-ENODEV bug)

  Regards,
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
