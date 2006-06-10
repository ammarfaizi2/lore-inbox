Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbWFJArW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbWFJArW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWFJArV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:47:21 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:37319 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030570AbWFJArV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:47:21 -0400
Date: Fri, 9 Jun 2006 20:47:19 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Rick Jones <rick.jones2@hp.com>
cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 5/6] [Network namespace] ipv4 isolation
In-Reply-To: <448A1208.3060602@hp.com>
Message-ID: <Pine.LNX.4.64.0606092046380.17553@d.namei>
References: <20060609210202.215291000@localhost.localdomain>
 <20060609210631.346330000@localhost.localdomain> <Pine.LNX.4.64.0606092022320.17380@d.namei>
 <448A1208.3060602@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Rick Jones wrote:

> > I think you'll need to make it so this code has zero impact when not
> > configured.
> 
> Indeed, and over stuff other than loopback too.  I'll not so humbly suggest :)

Yes, I meant the whole lot.



- James
-- 
James Morris
<jmorris@namei.org>
