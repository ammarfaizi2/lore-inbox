Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWBROvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWBROvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWBROvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:51:55 -0500
Received: from web50309.mail.yahoo.com ([206.190.38.242]:10579 "HELO
	web50309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751339AbWBROvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:51:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ij6GKKuMQqbrYl0TFoxqygaQhkq0/x32QcPOm/ItBnNzBMZO25j/IjH75z4TVtbCQb4W0tBcSasAEmhHzeOx92rpKCzPYOd957kM6IKA3uwYEvxR4o3Lw9kHJkyyhLbeBqpJnvR5EOzYfp57STDRp+8s2Feo0OAZsJkjia7bWBw=  ;
Message-ID: <20060218145152.85941.qmail@web50309.mail.yahoo.com>
Date: Sat, 18 Feb 2006 06:51:52 -0800 (PST)
From: omkar lagu <omkarlagu@yahoo.com>
Subject: kernel hook...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

help needed.. 
we want to call a function from the kernel code which
is defined in our module and the function should be
only called when we insert our module in the kernel.
we are really struggling with this..can anyone suggest
a solution for this with a example.

thanks in advance 

plz cc to omkarlagu@yahoo.com


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
