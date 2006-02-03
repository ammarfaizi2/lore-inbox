Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWBCVBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWBCVBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWBCVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:01:35 -0500
Received: from web50207.mail.yahoo.com ([206.190.38.48]:33359 "HELO
	web50207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030232AbWBCVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:01:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KqDC2Ex+c63BMVePGifxDwBruCZr1fG6c2703pcvvG4qfCMXEflKwX54qtYs6tozqeCiWyZkZEtoB2/kS/x84UY7Z8cWe3+qwGEYNjT82x5WLXS/YS+qLnlneULp+hcQHP0SKxamRVfPaXDbJ1032dZfpEOzH2bcZXaR+Pj7QkA=  ;
Message-ID: <20060203210132.97199.qmail@web50207.mail.yahoo.com>
Date: Fri, 3 Feb 2006 13:01:32 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: RE: Unable to read DVDs - what could be wrong?
To: linux-kernel@vger.kernel.org, helge.hafting@broadpark.no
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have that same model working flawlessly under 2.6.15.
Could you build a vanilla 2.6.15 kernel and test with that?
NOTE: Do NOT configure ide-scsi. There are issues with it 
which probably won't be resolved.

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
