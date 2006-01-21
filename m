Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWAUPkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWAUPkO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 10:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWAUPkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 10:40:14 -0500
Received: from web50210.mail.yahoo.com ([206.190.38.51]:52100 "HELO
	web50210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750811AbWAUPkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 10:40:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fTb0JBx6Owe36b0JhXqWp28uGO4XfkihUufqKxCiKKt12XqfO5VjI6JDkOLm9IkZ8gIBd3deeYvo2VdjrUfcuCj3v3Ot0QXCAQ6eLrySnRfsuV8SATaSzfbgJJGbidFBALZ6l6yQcchWeox6PIdMWdv8TfRMpx09n7gw5H+ZTy0=  ;
Message-ID: <20060121154012.66687.qmail@web50210.mail.yahoo.com>
Date: Sat, 21 Jan 2006 07:40:12 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [BUG] DVD assigned wrong SCSI level when using SCSI emulation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>I've noticed that since I upgraded to 2.6.15, my IDE DVD ROM
>>is assigned a bogus SCSI level. Here is output from /proc/scsi/scsi:
>
>You are not using ide-scsi, are you?
Yes, I am. as a module. I stated that in the original post.



I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
