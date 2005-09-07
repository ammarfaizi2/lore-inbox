Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVIGH22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVIGH22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVIGH22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:28:28 -0400
Received: from web52604.mail.yahoo.com ([206.190.48.207]:6511 "HELO
	web52604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751021AbVIGH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:28:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=C3qU02F1rUvU8D6A/3n+qCXltNbDs6362yAM7uREZuSOHU2ktyIRIVLtmIm+1qVbAlYTmSPZcMFJppZnsU7aN4e7VcsuWIbwU4td3AVK0SazHWUM2rkBxKACBeGBGSgELmkAsGbpW85bkzuF9DGP91T3SAyvh/FQpY1+sS9ZheQ=  ;
Message-ID: <20050907072824.98733.qmail@web52604.mail.yahoo.com>
Date: Wed, 7 Sep 2005 00:28:24 -0700 (PDT)
From: nazim khan <naz_taurus@yahoo.com>
Subject: How to find out kernel stack over flow?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I suspect that one of my module that I am inserting in
the kernel may be causing the stack overflow which is
leading to kernel crash (may because it is corrupting
some one lese memory).

How can I find this out?

Thanks in advance.
Nazim

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
