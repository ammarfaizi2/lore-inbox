Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272252AbTG3VmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272256AbTG3VmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:42:20 -0400
Received: from 217-124-17-250.dialup.nuria.telefonica-data.net ([217.124.17.250]:30102
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S272252AbTG3VmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:42:20 -0400
Date: Wed, 30 Jul 2003 23:42:19 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
Message-ID: <20030730214219.GA23265@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 30 July 2003, at 16:22:25 -0400,
Richard A Nelson wrote:

> all the ipsec and crypto stuff is modular, for the nonce, until I figure
> what I need/want.
> 
> most of the module not found messages are fine, its xfrm_type_2_50 that
> I'm worried about... What am I missing ?
> 
Maybe your kernel is missing "< > IPsec user configuration interface"
under "Networking options".

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-G7)
