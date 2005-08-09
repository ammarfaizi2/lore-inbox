Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVHIFxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVHIFxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHIFxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:53:52 -0400
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:11713 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932333AbVHIFxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:53:51 -0400
Date: Tue, 9 Aug 2005 01:53:49 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Madore <david.madore@ens.fr>
cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: understanding Linux capabilities brokenness
In-Reply-To: <20050809045916.GA3157@clipper.ens.fr>
Message-ID: <Pine.LNX.4.63.0508090152210.20505@excalibur.intercode>
References: <20050808211241.GA22446@clipper.ens.fr> <20050808223238.GA523@clipper.ens.fr>
 <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU> <20050809015048.GA14204@thunk.org>
 <20050809045916.GA3157@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, David Madore wrote:

> the "process management" part.  For example, I might like to run this
> or that binary, which claims it needs to be run as root, with a
> limited set of capabilities: the current Linux kernels make this quite
> impossible.

Not impossible with SELinux.


- James
-- 
James Morris
<jmorris@namei.org>
