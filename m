Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVAHNtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVAHNtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVAHNtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:49:03 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:46560 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261169AbVAHNs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:48:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=A3EWryltdL6acjna1WFFS2qvqcvweWoADBOzECvwKyZaDfCEbWEkTO2PUCPtLHbbAagoW6WYplbWpBak1Rm9B9dZqohSab6uIGv/dUjYYUYeGTuzDh8N1DMrwxAxDPIdz6do2prUDnM0eqJa3hM9gzx2+tVelD1BlyYHSaxmZ6M=
Message-ID: <21d7e99705010805487322533e@mail.gmail.com>
Date: Sun, 9 Jan 2005 00:48:56 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, Mike Werner <werner@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40f323d00501080427f881c68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <21d7e99705010718435695f837@mail.gmail.com>
	 <40f323d00501080427f881c68@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> if you look at the .config, agp and agp_via are not build as modules.
> 

can you also try a build with vesafb turned off? I'm just wondering is
there maybe a resource conflict or something like that going on ...

Dave.
