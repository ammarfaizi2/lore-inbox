Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbTJJIyH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTJJIyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:54:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60642 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262651AbTJJIyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:54:00 -0400
Date: Fri, 10 Oct 2003 01:48:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.0-test7-netx1
Message-Id: <20031010014822.0130ca61.davem@redhat.com>
In-Reply-To: <20031009155302.4f2fe835.shemminger@osdl.org>
References: <20031009155302.4f2fe835.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003 15:53:02 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

>     * TCP Vegas (from Dave Miller)

Please don't use a config option for this, that is why the
sysctl is there and off by default.
