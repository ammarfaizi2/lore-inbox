Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbTHTUTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTHTUTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:19:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:14292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbTHTUTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:19:52 -0400
Message-Id: <200308202019.h7KKJn528468@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Mitch Sako <msako@cadence.com>
cc: linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: 2.6.0-test3-mm2 recommended test bed 
In-Reply-To: Message from Mitch Sako <msako@cadence.com> 
   of "Tue, 19 Aug 2003 11:38:03 PDT." <3F426E8B.16F9BD54@cadence.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Aug 2003 13:19:49 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any recommendations on how to setup a basic IA32 test bed to install this kernel?
> 
> Distro?
> Version/release?
> Compiler version?
> glibc, binutils, etc.?
> 
> I want to test the 4GB/4GB stuff from Ingo but I'm having trouble getting a stable platform up and running.
> 
We run with RedHat 9.0 for a distro.
See Documentation/Changes in your kernel src tree for the other versions you 
mentioned.
Also, see http://www.osdl.org/stp/ for information on how we setup our 
testbeds.
cliffw

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


