Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTFKMDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTFKMDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:03:00 -0400
Received: from main.gmane.org ([80.91.224.249]:31980 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264389AbTFKMC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:02:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: RealTek NIC on alpha?
Date: 11 Jun 2003 14:16:31 +0200
Message-ID: <yw1x4r2wu7vk.fsf@zaphod.guide>
References: <20030611091910.GD801@rene-engelhard.de> <wrpznkp9d69.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Cc: debian-alpha@lists.debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <mzyngier@freesurf.fr> writes:

> Rene> 8139too Fast Ethernet driver 0.9.2
> Rene> and does not do anything after that.
> 
> Make sure CONFIG_8139TOO_PIO is set. I had similar problem on one of
> my Multias...

A friend of mine had to set the MAC address manually with one of those
cards.  After that it was fine.

-- 
Måns Rullgård
mru@users.sf.net

