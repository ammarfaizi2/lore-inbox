Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWIKIGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWIKIGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIKIGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:06:10 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:412 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751223AbWIKIGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:06:08 -0400
Date: Mon, 11 Sep 2006 04:06:05 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: David Madore <david.madore@ens.fr>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
In-Reply-To: <20060910160953.GA6430@clipper.ens.fr>
Message-ID: <Pine.LNX.4.64.0609110402250.15565@d.namei>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr>
 <1157905393.23085.5.camel@localhost.localdomain> <20060910160953.GA6430@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2006, David Madore wrote:

> Can a non-root user create limited-rights processes without assistance
> from the sysadmin, under SElinux?

SELinux uses a restrictive model, where privileges can only be removed, 
not added.



- James
-- 
James Morris
<jmorris@namei.org>
