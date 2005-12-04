Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVLDUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVLDUVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVLDUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:21:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932227AbVLDUVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:21:18 -0500
Date: Sun, 4 Dec 2005 15:20:55 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: anil dahiya <ak_ait@yahoo.com>
cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: virtual interface mac adress
In-Reply-To: <20051204192958.64093.qmail@web60214.mail.yahoo.com>
Message-ID: <Pine.LNX.4.63.0512041520320.29211@cuia.boston.redhat.com>
References: <20051204192958.64093.qmail@web60214.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2005, anil dahiya wrote:

> I want to assign mac addres to virtual adpater and mac
> address should be like that if it should not create
> problem in arp resoultion(i.e. mac address should be
> as real card which able to comunicate  on lan )

You may be able to get away with using a MAC address
inside the OUI range that XenSource registered.

-- 
All Rights Reversed
