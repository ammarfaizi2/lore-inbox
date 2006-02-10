Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWBJAVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWBJAVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWBJAVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:21:50 -0500
Received: from web50201.mail.yahoo.com ([206.190.38.42]:54608 "HELO
	web50201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750866AbWBJAVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:21:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eKu2aywBQfVuBubgeac9ncClTTqx1IJkhaNHKMfun89Qeh8aG2uehcH1eIehgo33cBPrRSenVZH/Fnuimi91P3MUiOS+6vMTI/81wlQ5oQFIFUwwXzwIlsfr8TicwcvbGBmFrA1SlP6uN/pPaxBqqK6fs0Jp0GbNd/f3pXHFiEU=  ;
Message-ID: <20060210002148.37683.qmail@web50201.mail.yahoo.com>
Date: Thu, 9 Feb 2006 16:21:48 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Let's get rid of  ide-scsi
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we should get rid of ide-scsi.

Reasons:
1) It's broken.
2) It's unmaintained.
3) It's unneeded.

I'll submit a patch if people agree.

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
