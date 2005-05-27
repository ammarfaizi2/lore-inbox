Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVE0WrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVE0WrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVE0WrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:47:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262630AbVE0Wqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:46:52 -0400
Date: Fri, 27 May 2005 18:46:36 -0400
From: Dave Jones <davej@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: mchan@broadcom.com, linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
Message-ID: <20050527224636.GA1677@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, mchan@broadcom.com,
	linville@tuxdriver.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, jgarzik@pobox.com
References: <20050527184750.GB11592@tuxdriver.com> <20050527.123037.68041200.davem@davemloft.net> <1117221859.4310.6.camel@rh4> <20050527.134032.78491984.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527.134032.78491984.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 01:40:32PM -0700, David S. Miller wrote:
 > From: "Michael Chan" <mchan@broadcom.com>
 > Date: Fri, 27 May 2005 12:24:19 -0700
 > 
 > > So in the future, do we need to patch this file or just let sourceforge
 > > take care of it?
 > 
 > I think the proper procedure is to send it to sourceforge.
 > But there is some latency in the changes making it back
 > into the kernel.

The latest diff vs mainline is always available at http://www.codemonkey.org.uk/projects/pci/
(Comedy aside, I dont even remember which box is running the cronjob that
 generates those files any more, good that its still ticking :-)

Greg did a sync up a while ago, but didn't seem too enthusiastic about
doing it regularly, due to the fact that /proc/pci is aparently going away.

		Dave

