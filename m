Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUEKQBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUEKQBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEKQBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:01:42 -0400
Received: from mail1.kontent.de ([81.88.34.36]:7601 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264798AbUEKQBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:01:41 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Ray Bryant <raybry@sgi.com>
Subject: Re: dynamic allocation of swap disk space
Date: Tue, 11 May 2004 18:00:59 +0200
User-Agent: KMail/1.6.2
Cc: Silviu Marin-Caea <silviu@genesys.ro>, linux-kernel@vger.kernel.org
References: <fa.n6pggn5.84en31@ifi.uio.no> <40A0EFC0.1040609@sgi.com>
In-Reply-To: <40A0EFC0.1040609@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111800.59640.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> thrash without filling up swap space.  It is true that systems can thrash AND 
> fill up swap space, but it is not always so.

However the system will also thrash if you have inactive dirty pages without
file backing taking up to much main memory. Albeit it is more a theoretical
possibilty.

	Regards
		Oliver
