Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSCDDGS>; Sun, 3 Mar 2002 22:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291086AbSCDDGI>; Sun, 3 Mar 2002 22:06:08 -0500
Received: from air-2.osdl.org ([65.201.151.6]:20233 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S291081AbSCDDF7>;
	Sun, 3 Mar 2002 22:05:59 -0500
Date: Sun, 3 Mar 2002 19:05:51 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Hans-Christian Armingeon <linux.johnny@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Recommendations about a 100/10 NIC
In-Reply-To: <16hcB4-12EIHAC@fmrl03.sul.t-online.com>
Message-ID: <Pine.LNX.4.33.0203031901530.28293-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Mar 2002, Hans-Christian Armingeon wrote:

| Am Sonntag, 3. März 2002 15:22 schrieb Justin Piszcz:
| > I'd reccomend a 3COM, as they come with a lifetime warranty and have always
| > been good for me.
| > Not sure about Intels.
| > I have a 3com 905b, the current model is a 3com 905C-TX like you mentioned.
| Which of those cards supports calculating ethernet checksums in hardware?

All of them do ethernet checksums^W CRCs in hardware.

Did you mean something like, "which ones do IP and/or TCP
checksums (offloads) in hardware?"

-- 
~Randy

