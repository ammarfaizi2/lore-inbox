Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbVLVUDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVLVUDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVLVUDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:03:53 -0500
Received: from web34115.mail.mud.yahoo.com ([66.163.178.113]:20393 "HELO
	web34115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030262AbVLVUDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:03:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OvSuj6K7Qf42pOCuznQSw5T77bDbfRuAU6K/Z2wnZCjbEeCxBtTukzhTg3f6DP3Zey7uv+1P1CN4LF0CbkPgaNc8OjDSntP8tYsr7uJtpPqoCUfbADZ6Dlx9ps6e1p5NYY5+T/RL+DA3KuoVH5cRctoMPxIJfg57b6BpDV+xS7k=  ;
Message-ID: <20051222200349.68299.qmail@web34115.mail.mud.yahoo.com>
Date: Thu, 22 Dec 2005 12:03:49 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: scsi errors with dpt-i2o driver
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135263384.2940.40.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Arjan van de Ven <arjan@infradead.org> wrote:
> > Are there any suggestions about how to diagnose further?  What about trying the native i2o
> driver?
> 
> that one is highly preferred anyway nowadays...

Is there a more recent reference than http://i2o.shadowconnect.com/faq.php, or a mailing list for
i2o driver issues?  For example, our bonnie runs suggest that dpt_i2o is a quite bit faster at
sequential writes, and how do we get the firmware rev of the controller from the i2o subsystem?

-Kenny



	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
