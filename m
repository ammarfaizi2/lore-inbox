Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWGYOoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWGYOoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGYOoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:44:20 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:1181 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932334AbWGYOoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:44:20 -0400
Date: Tue, 25 Jul 2006 10:44:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Venkat Yekkirala <vyekkirala@trustedcs.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] selinux: fix bug in security_compute_sid
In-Reply-To: <1153836816.7104.70.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0607251044010.21222@d.namei>
References: <1153836816.7104.70.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Stephen Smalley wrote:

> From: Venkat Yekkirala <vyekkirala@trustedcs.com>
> 
> Initializes newcontext sooner to allow for its destruction in all cases.
> Please apply for 2.6.18.
> 
> Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
