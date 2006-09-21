Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWIUNde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWIUNde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWIUNde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:33:34 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:11723 "EHLO csg-cluster.dwd.de")
	by vger.kernel.org with ESMTP id S1750976AbWIUNdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:33:33 -0400
Date: Thu, 21 Sep 2006 13:33:21 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Question regarding CONFIG_DMA_ENGINE
Message-ID: <Pine.LNX.4.64.0609211249160.9397@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Is setting this option and CONFIG_NET_DMA usefull even when you do not have
the hardware?

And what hardware is required for this? Is this DMA engine located on
the network or raid card, or is this something in the chipset? Which
chipset or cards do have such an engine?

Thanks,
Holger
-- 

