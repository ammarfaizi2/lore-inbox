Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRHKCRl>; Fri, 10 Aug 2001 22:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbRHKCRb>; Fri, 10 Aug 2001 22:17:31 -0400
Received: from zero.tech9.net ([209.61.188.187]:35592 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S266067AbRHKCRR>;
	Fri, 10 Aug 2001 22:17:17 -0400
Subject: Re: [PATCH] 2.4.7-ac11: Updated emu10k1 driver
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <997485043.692.23.camel@phantasy>
In-Reply-To: <997485043.692.23.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 10 Aug 2001 22:18:20 -0400
Message-Id: <997496304.898.82.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Aug 2001 19:10:29 -0400, Robert Love wrote:
> This brings 2.4.7-ac11 to the OSS Creative Open Source driver v0.15
> (specifically, a CVS dump from today, 20010810).  The previous version
> was v0.7, dating _200008_.

A revision of the patch is available at
http://www.tech9.net/rml/linux/patch-rml-2.4.7-ac11-emu10k1-2
and
http://www.tech9.net/rml/linux/patch-rml-2.4.7-emu10k1-2
for 2.4.7-ac11 and 2.4.7, respectively.  note the new 2.4.7 patch -- it
should apply cleanly to 2.4.7-pre series, too.

the previous patch included some portability wrappers that were unneeded
in the mainline kernel.  the new patch is thus smaller and cleaner.

the previous code should have no problem -- especially if used not as a
module -- and compile to the same code.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net
-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

