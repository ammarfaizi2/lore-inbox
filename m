Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVJ0UdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVJ0UdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJ0UdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:33:15 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:2695 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932216AbVJ0UdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:33:15 -0400
Subject: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 27 Oct 2005 22:33:14 +0200
Message-Id: <1130445194.5416.3.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I installed 4 x 1 GB DDR2 memory in my Intel Dual-Core 2.80GHz system,
but it shows me only 3.3 GB of RAM:

Memory: 3339124k/3398656k available (2029k kernel code, 56232k reserved,
741k data, 184k init)

The BIOS and dmidecode tells me that I have 4 GB of RAM installed and I
don't have any idea where to look for details. What information do you
need to analyze this?

Regards

Marcel


