Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWAUV3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWAUV3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWAUV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:29:20 -0500
Received: from natfrord.rzone.de ([81.169.145.161]:57513 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S932365AbWAUV3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:29:19 -0500
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel
	>= 2.6.15 rc1
From: Erwin Rol <mailinglists@erwinrol.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
In-Reply-To: <20060121125822.570b0d99.akpm@osdl.org>
References: <20060120123202.GA1138@epio.fluido.as>
	 <20060121010932.5d731f90.akpm@osdl.org>
	 <20060121125741.GA13470@epio.fluido.as>
	 <20060121125822.570b0d99.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 22:28:46 +0100
Message-Id: <1137878926.2976.28.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had also had the problem that my Shuttle ST20G5 (a RS480 IGP based
system) hung in pci_init. This was with one of the Fedora Rawhide
kernels, after reporting it  Dave Jones fixed it cause the next rawhide
kernel worked again, maybe he could explain what it was, and where the
fix is (if it is the same thing, but it really looks like it).

- Erwin



