Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWGGT1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWGGT1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWGGT1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:27:24 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:5792 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932278AbWGGT1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:27:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=qfdAtVBK2U6aAoJ9v9Jp1uEyF+8xi1U12oNHFT1ZDXT95yBkpRe8srjB5dNzEz/Ygi5JDcUYMubSsbTYJeyzoqPNpyu/RIj62abOMb21uG6uvP17wSNohsmsfWIkFlqBD05uFSwAjpL5YoUBOzSko//dSnxETCVs4MfhxwMV0+k=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Jan Rychter'" <jan@rychter.com>, <linux-kernel@vger.kernel.org>
Cc: <suspend2-devel@lists.suspend2.net>
Subject: RE: swsusp / suspend2 reliability
Date: Fri, 7 Jul 2006 12:27:06 -0700
Message-ID: <018b01c6a1fb$59f74b80$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <m2k66qzgri.fsf@tnuctip.rychter.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcahMW/uiS2itg14ROiSUstdZnA1oAAvx56A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Accept the facts -- for some reason, there is a fairly large 
> user base that goes to all the bother of using suspend2, 
> which requires downloading, patching and all the extra work. 
> People do it, in spite of the wonderful swsusp being in the 
> kernel and all the other extra cool stuff being worked on.
> 
> That is a fact, and all the hand waving won't change it.

Truth is always painful. :-)

Greg had a good article on LWN: http://lwn.net/Articles/189467/. There you could find a more painful truth. You know what the real
reason is that suspend2 couldn't get merged? Not Nigel, not Pavel, but Linus, because he personally doesn't care. So if you want to
have a high-quality suspend-to-disk, your best bet is to convince Linus to use it. :-)

(well I'm partly joking here, but the above article and the corresponding thread is a well-worthy read
(http://thread.gmane.org/gmane.linux.power-management.general/1884/focus=1884).

Some of the Linus quotes that you may find interesting :-)
http://article.gmane.org/gmane.linux.power-management.general/1974
http://article.gmane.org/gmane.linux.power-management.general/1996
http://article.gmane.org/gmane.linux.power-management.general/2105
http://article.gmane.org/gmane.linux.power-management.general/2193



