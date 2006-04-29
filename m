Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWD2IBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWD2IBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWD2IBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:01:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50662 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751088AbWD2IBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:01:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/3] powerpc: Make rtas console _much_ faster
Date: Sat, 29 Apr 2006 10:00:52 +0200
User-Agent: KMail/1.9.1
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Ryan Arnold <rsa@us.ibm.com>
References: <20060429004019.126937000@localhost.localdomain> <200604290245.57507.arnd@arndb.de> <1146275817.14733.2.camel@localhost.localdomain>
In-Reply-To: <1146275817.14733.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604291000.52541.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 03:56, Michael Ellerman wrote:
> I'll clean this one up a little before merging it as per Ryan's email of
> a week or two ago. New patch today or tomorrow.

Ok, I misremembered the discussion on that patch and it didn't occur
to me that a one-line patch needs cleanup ;-)

Thanks!

> Even though this is 1/3 the rest of the series should be fine to merge,
> right Arnd?

Yes.

	Arnd <><
