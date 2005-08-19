Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVHSXXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVHSXXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbVHSXXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:23:49 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:52334 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S932344AbVHSXXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:23:49 -0400
Date: Sat, 20 Aug 2005 01:23:40 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Pekka Enberg <penberg@gmail.com>
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Documentation] Use doxygen or another tool to generate a documentation ?
Message-ID: <20050819232340.GB9538@localhost.localdomain>
References: <20050819213447.GA9538@localhost.localdomain> <84144f02050819144660238be4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <84144f02050819144660238be4@mail.gmail.com>
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090202.43066761.0006-F-L0BeBC04zsV01UPbcJcIKw==, ip=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Saturday 20 August 2005 a 00:08, Pekka Enberg ecrivait: 
> On 8/20/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> > I don't know if there is a project based on Doxygen to make
> > (or generate) a documentation of the kernel.
> > 
> > Do you think that will be interesting to make a such document ?
> 
> The kernel already has it's own API documentation generator called
> kerneldoc. See the file Documentation/kernel-doc-nano-HOWTO.txt for
> details.

Ok, with scripts/kernel-doc, I can produce some html files containing 
the functions' documentation.

make pdfdocs or others targets don't work :|

Do you have ideas ?

Thanks
-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>


