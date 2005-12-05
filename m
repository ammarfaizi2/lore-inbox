Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVLEVc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVLEVc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLEVc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:32:59 -0500
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:28314 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750778AbVLEVc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:32:59 -0500
Date: Mon, 5 Dec 2005 16:32:52 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tobias Klauser <tklauser@nuerscht.ch>, Nicolas Kaiser <nikai@nikai.net>
Subject: Re: [patch 1/2] selinux:  ARRAY_SIZE cleanups
In-Reply-To: <1133793642.20862.61.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0512051632320.11318@excalibur.intercode>
References: <1133793642.20862.61.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Stephen Smalley wrote:

> From: Nicolas Kaiser <nikai@nikai.net>
> 
> Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]).
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
