Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289885AbSAPGbo>; Wed, 16 Jan 2002 01:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290364AbSAPGbe>; Wed, 16 Jan 2002 01:31:34 -0500
Received: from nat.transgeek.com ([66.92.79.28]:30964 "EHLO smtp.transgeek.com")
	by vger.kernel.org with ESMTP id <S289885AbSAPGbR>;
	Wed, 16 Jan 2002 01:31:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: likely/unlikely
Date: Wed, 16 Jan 2002 01:32:30 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020116032300.AAA27749@shell.webmaster.com@whenever> <3C450C4A.8A8382A6@mandrakesoft.com>
In-Reply-To: <3C450C4A.8A8382A6@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116113143.C99F8B581@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> likely/unlikely set the branch prediction values to 99% or 1%


	So all of the BUG() routines in the kernel would benifit greatly from this.



Craig.
