Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbTHKEf3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271006AbTHKEf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:35:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7154 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S271003AbTHKEfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:35:25 -0400
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts
	seems correct
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: cmrivera@ufl.edu, linux-kernel@vger.kernel.org
In-Reply-To: <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>
References: <1060572792.1113.10.camel@boobies.awol.org>
	 <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>
	 <1060574873.684.41.camel@localhost>
	 <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>
Content-Type: text/plain
Message-Id: <1060576517.684.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sun, 10 Aug 2003 21:35:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-10 at 21:33, Randy.Dunlap wrote:

> Ugh-ly?  We can move it to sysfs and then change the file format
> to intnum:count pairs (e.g.).

But then how is it different from /proc/interrupts ?

	Robert Love


