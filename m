Return-Path: <linux-kernel-owner+w=401wt.eu-S1751821AbWLNGBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWLNGBK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWLNGBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:01:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:61860 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbWLNGBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:01:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=FkvnPvR3Mm8x4J/c+yCNB+cxaPG1WX+rzJuxx/aH0uEJvIBZ2b4fAyk/Rs9VdeU25FQcTzeKRRoY7U5M0aXkW9HuVC6IVWF3xRpBpwvZXgSyMK9lEu/+US5DE54o0Rc2ALVgEd4CWDbavilo+ann9hY351d9IG8Z8rrY1L2OYgc=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Greg KH'" <gregkh@suse.de>, "'Jonathan Corbet'" <corbet@lwn.net>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Wed, 13 Dec 2006 22:01:15 -0800
Message-ID: <003801c71f45$45d722c0$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <4580E37F.8000305@mbligh.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AccfQysdYDQCd77/Tc2QVub3YuyzAgAAedzg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think allowing binary hardware drivers in userspace hurts 
> our ability to leverage companies to release hardware specs. 

If filesystems can be in user space, why can't drivers be in user space? On what *technical* ground?

