Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWHWTpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWHWTpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWHWTpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:45:20 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:63957 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965154AbWHWTpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:45:17 -0400
Date: Wed, 23 Aug 2006 15:45:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: gerrit@erg.abdn.ac.uk
cc: davem@davemloft.net, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] net/ipv4: UDP-Lite extensions
In-Reply-To: <Pine.LNX.4.64.0608231112530.3870@d.namei>
Message-ID: <Pine.LNX.4.64.0608231544270.5573@d.namei>
References: <200608231150.42039@strip-the-willow> <Pine.LNX.4.64.0608231019010.3198@d.namei>
 <200608231603.08240@strip-the-willow> <Pine.LNX.4.64.0608231112530.3870@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, James Morris wrote:

> continue executing.  Although, it's not entirely clear how to determine 
> this, e.g. perhaps the system should panic if netfilter initialization 
> failed, as it might mean that the systems comes up without a firewall.

Actually, I guess it's up to userspace to figure this out.



- James
-- 
James Morris
<jmorris@namei.org>
