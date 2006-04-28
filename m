Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWD1FM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWD1FM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWD1FM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:12:59 -0400
Received: from ms-smtp-02.southeast.rr.com ([24.25.9.101]:27077 "EHLO
	ms-smtp-02.southeast.rr.com") by vger.kernel.org with ESMTP
	id S965159AbWD1FM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:12:59 -0400
Subject: Re: s390 lcs incorrect test
From: Greg Smith <gsmith@nc.rr.com>
To: Frank Pavlic <PAVLIC@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
In-Reply-To: <OFD0B5D01B.AB09BC08-ONC125715D.0018D87C-C125715D.00190DD5@de.ibm.com>
References: <OFD0B5D01B.AB09BC08-ONC125715D.0018D87C-C125715D.00190DD5@de.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 01:12:52 -0400
Message-Id: <1146201172.3064.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have discovered today our bug regarding lcs emulation and everything
seems to work fine even with the incorrect test.  Which leads me to
think that the lcs code has been crafted to withstand the incorrect
test.  Meaning that correcting the test may have implications.

Greg Smith

On Thu, 2006-04-27 at 06:34 +0200, Frank Pavlic wrote:
> I agree , it's really weird ...
> 
> Thank you Greg for the patch ...


