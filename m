Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280922AbRKCB5I>; Fri, 2 Nov 2001 20:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280923AbRKCB46>; Fri, 2 Nov 2001 20:56:58 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:5253 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S280922AbRKCB4i>;
	Fri, 2 Nov 2001 20:56:38 -0500
Message-ID: <3BE35151.72B71462@sun.com>
Date: Fri, 02 Nov 2001 18:07:13 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Christian Lavoie <clavoie@bmed.mcgill.ca>, linux-kernel@vger.kernel.org
Subject: Re: Disabling CPUs -- at runtime?
In-Reply-To: <20011102232536Z280877-17408+9634@vger.kernel.org> <3BE32B9E.99F57470@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" wrote:

> There's a patch [out of date :( ] at
> sourceforge.net/projects/lhcs/ that does this (CPU online/offline).

pset allows this, though pset has not been fully ported to 2.4.x yet...


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
