Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTDLI2Z (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 04:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTDLI2Z (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 04:28:25 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:43940 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263199AbTDLI2Z (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 04:28:25 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: miquels@cistron-office.nl (Miquel van Smoorenburg),
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 10:40:07 +0200
User-Agent: KMail/1.5
References: <20030411172011.GA1821@kroah.com> <20030412000829.GL4539@kroah.com> <b77m71$7bs$1@news.cistron.nl>
In-Reply-To: <b77m71$7bs$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304121040.07947.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The pipe/socket solution is probably better anyway, I was just
> wondering why /sbin/hotplug wasn't serialized from the start.

It was. Deadlocks happened and the semaphore was removed.
I don't remember details. They might be in the archives.

	HTH
		Oliver

