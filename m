Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUFQTMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUFQTMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFQTMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:12:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3474 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261830AbUFQTJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:09:43 -0400
Date: Thu, 17 Jun 2004 12:09:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: igmp warning (was: Re: Linux 2.4.27-pre6)
Message-Id: <20040617120914.2e70f768.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.58.0406172058000.1495@waterleaf.sonytel.be>
References: <20040616183343.GA9940@logos.cnet>
	<Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be>
	<Pine.GSO.4.58.0406172058000.1495@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Indeed, a 2.6.x bugfix got put into 2.4.x but it was not relevant
there at all.

Will fix this, thanks Geert.
