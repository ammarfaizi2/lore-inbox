Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSJWKjI>; Wed, 23 Oct 2002 06:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSJWKjI>; Wed, 23 Oct 2002 06:39:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8836 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264624AbSJWKjH>;
	Wed, 23 Oct 2002 06:39:07 -0400
Date: Wed, 23 Oct 2002 03:36:53 -0700 (PDT)
Message-Id: <20021023.033653.102784353.davem@redhat.com>
To: mzyngier@freesurf.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.44 : /proc/net/arp broken
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <wrphefd5te3.fsf@hina.wild-wind.fr.eu.org>
References: <wrphefd5te3.fsf@hina.wild-wind.fr.eu.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apply Arnaldo's patches he posted last week, see if that
cures the problem, if not bug him :-)
