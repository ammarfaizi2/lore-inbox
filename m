Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVAIBXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVAIBXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVAIBXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:23:30 -0500
Received: from mproxy.gmail.com ([216.239.56.250]:23505 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262179AbVAIBXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:23:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Z8Khi9agKxcD70r109MeJQQM8yf6YIKD6j0V5Bj44SmEawFPzl+JG6wIQXkdiVzw2wSkBUrdDS06aZ0eyYPCqE3Jr9vQDs/0QVPIEwaBsvUAl4Dk1ege8hBXshOVxyk4w0QhTyDvwnNtZlI0RY7E8qqS2vDKCq4GCv5OZNSCWpw=
Message-ID: <21d7e99705010817237953af95@mail.gmail.com>
Date: Sun, 9 Jan 2005 12:23:10 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: 2.6.10-mm2
Cc: bboissin@gmail.com, akpm@osdl.org, werner@sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050108151816.2a9c318f.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <21d7e99705010718435695f837@mail.gmail.com>
	 <40f323d00501080427f881c68@mail.gmail.com>
	 <21d7e99705010805424ec16550@mail.gmail.com>
	 <20050108151816.2a9c318f.Ballarin.Marc@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any ideas Mike why that might happen?
> 
> Could this be the same issue discussed and fixed in another thread?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110504486230527&w=2
> 

that fix is needed anyways, but this happens before that...

Dave.
