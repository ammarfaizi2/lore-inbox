Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945955AbWBCU4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945955AbWBCU4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945954AbWBCU4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:56:09 -0500
Received: from web50205.mail.yahoo.com ([206.190.38.46]:55701 "HELO
	web50205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1945955AbWBCU4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:56:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dDs4PzLbr219lISIyCsrqz15dowQPjlATzr7leRfs6rmFXxMuoiJH7LczMIzf/dmkyHns6g+6UDY6SYoQ6PRaMCqxpY8NudL4N8sNESkqqlGqSwMImuN6WiYEA2wjepsynZeH/KnbYEd3XG3zP8bBfrLa9PxTuZAE7VmGp/d6ec=  ;
Message-ID: <20060203205605.85529.qmail@web50205.mail.yahoo.com>
Date: Fri, 3 Feb 2006 12:56:05 -0800 (PST)
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
