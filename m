Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVBOUrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVBOUrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVBOUp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:45:56 -0500
Received: from gumby.rupert.net ([204.244.98.46]:25041 "EHLO gumby.citytel.net")
	by vger.kernel.org with ESMTP id S261878AbVBOUmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:42:35 -0500
Subject: 2.6 ISA PnP Development
From: Geoff <geoffc@charleshays.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Feb 2005 12:45:53 -0800
Message-Id: <1108500353.4521.11.camel@Abyss>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need some helping writing a 2.6 ISA PnP kernel module. Can't find any
docs. I'm writing a probe function, but cannot understand how to get
vendor/function IDs off my card, and specify them in the correct format
in my code. Been using 3c509 driver as reference. A blank PnP module
template with lots of comments would be a blessing :-)

I'm not subscribed to the list, so please CC: my mail address. 

Thanks,
Geoff Crawford

