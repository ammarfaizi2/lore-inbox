Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281995AbRKUXZc>; Wed, 21 Nov 2001 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281996AbRKUXZL>; Wed, 21 Nov 2001 18:25:11 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:17448 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S281995AbRKUXZB>; Wed, 21 Nov 2001 18:25:01 -0500
Date: Wed, 21 Nov 2001 17:24:44 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Joseph Fannin <jhf@rivenstone.net>
cc: Anders Linden <anli@perceptive.se>, linux-kernel@vger.kernel.org
Subject: Re: Network card timeouts
In-Reply-To: <20011121154836.A9016@gibraltar.rivenstone.net>
Message-ID: <Pine.LNX.3.96.1011121172341.24649A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think what people sometimes do not understand is that transmit
timeouts are a generic handler for a NIC- or driver-specific problem

It is a mistake to assume that timeouts are a "common thread" of any
sort.

	Jeff



