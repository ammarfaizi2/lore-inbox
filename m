Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVBXQFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVBXQFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVBXQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:03:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58858 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262393AbVBXQBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:01:49 -0500
Date: Thu, 24 Feb 2005 11:01:39 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
Message-ID: <20050224160139.GF853@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <16924.59237.581247.498382@alkaid.it.uu.se> <1109210688.15027.2.camel@gaston> <16925.60927.49095.758660@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16925.60927.49095.758660@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 04:08:47PM +0100, Mikael Pettersson wrote:
> _However_, the 0k data message is due to a gcc-4.0 bug, and below
> you'll find a test program which illustrates it.

http://gcc.gnu.org/PR20196

	Jakub
