Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271706AbRIHR0a>; Sat, 8 Sep 2001 13:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271761AbRIHR0U>; Sat, 8 Sep 2001 13:26:20 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:12084 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271706AbRIHR0K>; Sat, 8 Sep 2001 13:26:10 -0400
Subject: Re: Linux 2.4.9-ac10
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
In-Reply-To: <20010907175943.V29607@mikef-linux.matchmail.com>
In-Reply-To: <20010908005500.A11127@lightning.swansea.linux.org.uk> 
	<20010907175943.V29607@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 08 Sep 2001 13:26:40 -0400
Message-Id: <999970007.840.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-07 at 20:59, Mike Fedyk wrote:
> Alan,
> 
> Do you have any plans to merge the entropy from Network patch?

While I would love to see the network entropy patch merged into 2.4 (its
an option -- plus, since it standardizes the handfull of drivers that
currently _do_ contribute to the entropy pool, its a nice cleanup) I am
aiming for 2.5.

I keep the patch up to date with both Linus's and Alan's tree.  Patches
against the current kernel can be found at http://tech9.net/rml/linux/ -
2.4.9-ac10 patches are up.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

