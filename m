Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVGVSh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVGVSh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVGVShf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:37:35 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:2957 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261376AbVGVShc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:37:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=p/A5DqiwF61kTEMHNUz7VTrV7V+OHqzTKeAYvGGUAfdMpMx+jVrfE5Y/+JaM+IpKmWTeTMrQvQz7AzDNdC435x4AANDJIjoS5UYqC99B00djcxZC4O4bhGeXkDC7438+m1LeEQ8YwTk6U9fLYBM9oAMkoDjVPWKk6TsTC8gaAhc=
Date: Fri, 22 Jul 2005 20:36:46 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Andre Eisenbach <int2str@gmail.com>
Cc: bert.hubert@netherlabs.nl, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: fastboot, diskstat
Message-Id: <20050722203646.4e6368e5.diegocg@gmail.com>
In-Reply-To: <7f800d9f0507220016d8c26e6@mail.gmail.com>
References: <20050722034135.GA21201@outpost.ds9a.nl>
	<7f800d9f0507220016d8c26e6@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 22 Jul 2005 00:16:38 -0700,
Andre Eisenbach <int2str@gmail.com> escribió:

> So checkout initng for your tests. It's a highly parallelized init
> system which seriously speeds up boot. It also keeps the disks much
> busier during boot and might help your testing.
> 
> Initng:
> http://initng.thinktux.net

It's also interesting that people is porting Mac OS X's launchd to FreeBSD (which
has helped mac os x to improve boot times)

http://developer.apple.com/documentation/Darwin/Reference/ManPages/man8/launchd.8.html
http://wikitest.freebsd.org/moin.cgi/launchd
