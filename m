Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267460AbSLEVM0>; Thu, 5 Dec 2002 16:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbSLEVLc>; Thu, 5 Dec 2002 16:11:32 -0500
Received: from rth.ninka.net ([216.101.162.244]:22487 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267455AbSLEVKd>;
	Thu, 5 Dec 2002 16:10:33 -0500
Subject: Re: hidden interface (ARP) 2.4.20
From: "David S. Miller" <davem@redhat.com>
To: Bingner Sam J Contractor PACAF CSS/SCHE 
	<Sam.Bingner@hickam.af.mil>
Cc: "'ja@ssi.bg'" <ja@ssi.bg>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 13:42:10 -0800
Message-Id: <1039124530.18881.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 12:53, Bingner Sam J Contractor PACAF CSS/SCHE
wrote:
> Attached is a patch that seems to work for the hidden flag in 2.4.20... for
> anybody else who needs this functionality

Use the ARP filter netfilter module or the routing based solutions
instead, please.

