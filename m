Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTDNTFl (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTDNTFk (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:05:40 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:39142 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263866AbTDNTE7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:04:59 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Date: Mon, 14 Apr 2003 21:16:45 +0200
User-Agent: KMail/1.5
References: <20030414190032.GA4459@kroah.com>
In-Reply-To: <20030414190032.GA4459@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142116.45303.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Any objections or comments?  If not, I'll make the changes in the
> linux-hotplug project and release a new version based on this.

Yes, consider what this does if you connect to a FibreChannel
grid. You are pushing system load by at least an order of magnitude.

	Regards
		Oliver

