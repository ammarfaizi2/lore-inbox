Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWHQP4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWHQP4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWHQP4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:56:31 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:11965 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932543AbWHQP4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:56:30 -0400
Message-ID: <44E490CA.8070603@s5r6.in-berlin.de>
Date: Thu, 17 Aug 2006 17:52:42 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Anonymous User <anonymouslinuxuser@gmail.com>
CC: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Patrick McFarland <diablod3@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: GPL Violation?
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <40d80630608170758h801504boebb92563238d8b06@mail.gmail.com>
In-Reply-To: <40d80630608170758h801504boebb92563238d8b06@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous User wrote:
> Thanks to everyone who has responded to my question so far.
> 
> It seems like the two issues that need to be addressed are:
> 1) Are the kernel modules being developed derived works?  If they are,
> they must be released along with the entire kernel source.
> 2) If they are not derived works, and shipped in a product, does the
> fact that they are shipped in a product that uses the linux kernel
> require that the new modules be licensed under the GPL?

If you refer to "kernel modules" in the commonly used sense of the term,
i.e. modules that are linked into the kernel's address space and use its
symbols, then at least the FSF's lawyers' interpretation of the GPL is
unmistakable.
-- 
Stefan Richter
-=====-=-==- =--- =---=
http://arcgraph.de/sr/
