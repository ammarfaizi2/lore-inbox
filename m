Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTICGjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTICGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:39:49 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:5127 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S263716AbTICGjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:39:48 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: [DEBUG] 2.6.0-test4 - sleeping function called from invalid context
Date: Tue, 2 Sep 2003 23:25:34 +0100
User-Agent: KMail/1.5.3
References: <1062520736.2331.10.camel@poohbox.perlaholic.com> <20030902173320.GM4306@holomorphy.com>
In-Reply-To: <20030902173320.GM4306@holomorphy.com>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309022325.34925.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 Sep 2003 18:33, William Lee Irwin III wrote:
> On Wed, Sep 03, 2003 at 02:38:56AM +1000, Stuart Low wrote:
> > - -snip- -
> > nvidia: no version magic, tainting kernel.
> > nvidia: module license 'NVIDIA' taints kernel.
> > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496
> > Wed Jul 16 19:03:09 PDT 2003
> > Debug: sleeping function called from invalid context at mm/slab.c:1817
>
> Looks very much like an nvidia problem; best to report it to them.

If it's any help, I've got the nvidia module working okay with the patches 
for the 2.5+ kernels from www.minion.de -- when I last looked, nvidia hadn't 
released their own version for 2.6.0.

M 

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
