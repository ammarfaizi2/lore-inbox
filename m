Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161227AbWG1SmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbWG1SmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWG1SmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:42:24 -0400
Received: from ns.suse.de ([195.135.220.2]:3748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161227AbWG1SmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:42:23 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Date: Fri, 28 Jul 2006 20:42:47 +0200
User-Agent: KMail/1.9.1
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net> <1154104048.6416.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1154104048.6416.25.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607282042.47840.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 18:27, Arjan van de Ven wrote:

> I won't rule anything out, but for some it'll be impossible (such as
> i386). It'll depend on the exact architecture I suppose.. for x86_64 a
> gcc patch was needed 

Did the patch make 4.1.0? 

-Andi
