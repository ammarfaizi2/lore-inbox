Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWGIKgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWGIKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWGIKgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:36:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:10138 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030446AbWGIKgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:36:16 -0400
Subject: Re: Linux v2.6.18-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Fox <drfickle@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <pan.2006.07.07.15.41.35.528827@us.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 20:34:02 +1000
Message-Id: <1152441242.4128.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> We've got a ppc64 machine that won't boot with this due to an IDE error.

What machine precisely ?

> [snip]
> Freeing unused kernel memory: 256k freed
>  running (1:2) /init autobench_args: ABAT:1152213829
> 
> creating device nodes .hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> 

