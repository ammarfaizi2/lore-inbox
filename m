Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270240AbUJTTZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270240AbUJTTZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbUJTTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:17:52 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:58123 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269119AbUJTTQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:16:33 -0400
Date: Wed, 20 Oct 2004 14:11:46 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, davem@davemloft.net,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com, akpm@osdl.org,
       romieu@fr.zoreil.com, ctindel@users.sourceforge.net, fubar@us.ibm.com,
       greearb@candelatech.com
Subject: [patch 2.6.9 0/11] Add MODULE_VERSION to several network drivers
Message-ID: <20041020141146.C8775@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, davem@davemloft.net, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
	ctindel@users.sourceforge.net, fubar@us.ibm.com,
	greearb@candelatech.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches to add MODULE_VERSION lines to several network drivers...

Here is the list:

	tg3
	e100
	e1000
	b44
	tulip
	3c59x
	8139too
	ns83820
	r8169
	bonding
	vlan

Individual patches to follow...

John
-- 
John W. Linville
linville@tuxdriver.com
