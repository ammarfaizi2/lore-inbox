Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264792AbSKEKoO>; Tue, 5 Nov 2002 05:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264793AbSKEKoN>; Tue, 5 Nov 2002 05:44:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:7616 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S264792AbSKEKoN>;
	Tue, 5 Nov 2002 05:44:13 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <20021105094741.A32344@bitwizard.nl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E1891IG-0006hN-00@sites.inka.de>
Date: Tue, 5 Nov 2002 11:50:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021105094741.A32344@bitwizard.nl> you wrote:
> Capabilties done right, means that normal users DO have capabilities. 
> Normal users have the capability to call normal syscalls like "read", 
> "write" and "execve".

This is IMHO very desireable, but not part of POSIX capabilties and also
even more intrusive on the applications.

Even on Windows NT you do not have such User capabilties. With a good
namespace and ACL concept, you can get around it, most of the time.
(although a object based security is not always as good as a subject bound).

Greetings
Bernd
