Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbTCZUMt>; Wed, 26 Mar 2003 15:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbTCZUMt>; Wed, 26 Mar 2003 15:12:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39902 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262048AbTCZUMs>;
	Wed, 26 Mar 2003 15:12:48 -0500
Date: Wed, 26 Mar 2003 12:19:42 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] bug 508: ipmi compile fix
Message-Id: <20030326121942.74df8bf6.rddunlap@osdl.org>
In-Reply-To: <1048706090.748.7.camel@localhost>
References: <1441850000.1048704979@flay>
	<1048706090.748.7.camel@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 2003 14:14:50 -0500 Robert Love <rml@tech9.net> wrote:

| On Wed, 2003-03-26 at 13:56, Martin J. Bligh wrote:
| 
| > Problem Description: drivers/char/ipmi/ipmi_devintf.c:452
| > 'snprinf' should be 'snprintf'
| 
| Sheesh, diffing the solution is certainly quicker than filling out the
| bugzilla entry...
| 
| Patch is against 2.5.66.  Linus, please apply.

Exactly what I said before I saw your patch.  :)

--
~Randy
