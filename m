Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbTAURUk>; Tue, 21 Jan 2003 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbTAURUk>; Tue, 21 Jan 2003 12:20:40 -0500
Received: from rth.ninka.net ([216.101.162.244]:52637 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267124AbTAURUj>;
	Tue, 21 Jan 2003 12:20:39 -0500
Subject: Re: SIOCGSTAMP does not work ?
From: "David S. Miller" <davem@redhat.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.51.0301211636500.3454@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0301211636500.3454@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Jan 2003 10:07:35 -0800
Message-Id: <1043172455.16483.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 07:44, Maciej Soltysiak wrote:
> 1. Is this all really related?

No.

> 2. Why is TCP_CHECK_TIMER not coded ?

It is a debugging check, it has nothing to do with SIOCGSTAMP.

