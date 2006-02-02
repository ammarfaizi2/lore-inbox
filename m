Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWBBQk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWBBQk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWBBQk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:40:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50122 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932149AbWBBQkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:40:25 -0500
Subject: Re: Re[2]: DEVICE POLLING
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kasp <waters@inbox.lv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <12329232343.20060202175530@inbox.lv>
References: <293455779.20060202104554@inbox.lv>
	 <1138891187.9861.7.camel@localhost.localdomain>
	 <12329232343.20060202175530@inbox.lv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 16:41:53 +0000
Message-Id: <1138898513.9861.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-02 at 17:55 +0200, kasp wrote:
> Should I turn this feature somewhere on, or is it already enabled by default?
> I'm using Intel PRO/100 network cards if it's important.

Its the "NAPI" options in the make config stage. Or see the NAPI howto
in the kernel source tree

