Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263960AbTDWFtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 01:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTDWFtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 01:49:39 -0400
Received: from dp.samba.org ([66.70.73.150]:51584 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263960AbTDWFti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 01:49:38 -0400
Date: Wed, 23 Apr 2003 15:46:36 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       David Hinds <dhinds@sonic.net>
Subject: Update to orinoco driver (2.4)
Message-ID: <20030423054636.GG25455@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
	David Hinds <dhinds@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

The patch below updates the orinoco driver in 2.4 to 0.13d, the patch
is against 2.4.21-rc1.  You may want to postpone this update till
after 2.4.21, but I'd consider it, since it fixes a fair slew of bugs.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
