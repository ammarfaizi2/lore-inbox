Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbTKTACA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 19:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTKTACA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 19:02:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:62898 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264194AbTKTAB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 19:01:59 -0500
Date: Wed, 19 Nov 2003 15:55:54 -0800
From: Greg KH <greg@kroah.com>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB] uhci-hcd.c: b400: host controller halted after ACPI S3
Message-ID: <20031119235554.GE23599@kroah.com>
References: <E1AMZqy-0005qp-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AMZqy-0005qp-00@penngrove.fdns.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 01:27:12PM -0800, John Mock wrote:
>     Oh! Good! I'm also trying to get this fixed, but I haven't seen any
>     progress on this issue (if my memory serves me well, Greg hadn't access
>     to a system with UHCI-HCD host controller to test).

I have access to UHCI controllers, just haven't tested sleep on them,
that's all.  Hopefully in a few weeks I'll have the time to.

greg k-h
