Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTDKRGg (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTDKRGf (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:06:35 -0400
Received: from [212.18.235.100] ([212.18.235.100]:25358 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261358AbTDKRGc (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:06:32 -0400
Subject: Re: [ANNOUNCE] udev 0.1 release
From: Justin Cormack <justin@street-vision.com>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Greg KH <greg@kroah.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <1050081047.1252.4.camel@contact.skynet.coplanar.net>
References: <20030411032424.GA3688@kroah.com> 
	<1050081047.1252.4.camel@contact.skynet.coplanar.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 11 Apr 2003 18:18:09 +0100
Message-Id: <1050081489.1363.114.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 18:10, Jeremy Jackson wrote:
> What about read-only root fs? 

run it on a tmpfs partition mounted at /dev


Justin


