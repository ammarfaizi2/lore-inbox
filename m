Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTK0T6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 14:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTK0T6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 14:58:41 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:11137
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261774AbTK0T6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 14:58:40 -0500
Date: Thu, 27 Nov 2003 14:57:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Rene Engelhard <rene@rene-engelhard.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11: MII broken?
In-Reply-To: <20031127124230.GA1275@rene-engelhard.de>
Message-ID: <Pine.LNX.4.58.0311271456510.2648@montezuma.fsmlabs.com>
References: <20031127124230.GA1275@rene-engelhard.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0311271456512.2648@montezuma.fsmlabs.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003, Rene Engelhard wrote:

> [ please Cc: me as I am not subscribed ]
>
> Hi,
>
> I wondered why my automatic network detection with whereami doesn't
> work anymore. Now I found it:
>
> rene@frodo:~$ sudo mii-tool eth0
> SIOCGMIIPHY on 'eth0' failed: Operation not supported

Try upgrading your mii-tool
