Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUFJOvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUFJOvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUFJOvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:51:48 -0400
Received: from tristate.vision.ee ([194.204.30.144]:33738 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S261530AbUFJOvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:51:04 -0400
Message-ID: <40C8756B.6050501@vision.ee>
Date: Thu, 10 Jun 2004 17:51:23 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lars <terraformers@gmx.net>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
References: <ca9jj9$dr$1@sea.gmane.org> <200406101459.45750.bzolnier@elka.pw.edu.pl> <ca9nid$bnc$1@sea.gmane.org>
In-Reply-To: <ca9nid$bnc$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars wrote:

>hi
>
>thanks for answering!
>
>rc2 worked completely stable with c1 disconnect halt enabled and low
>cpu temp.
>  
>
I've kind of opposite here. with rc2-mm2 boot message says that fixup is 
applied. "athcool stat" says 'c1 bit disabled'.
Everything stable. When I enable that bit with "athcool on" the system 
will lock up solid after an hour or so.

With 2.6.1-rc1-mm1 I could enable that bit manually and everything was 
still stable afterwards ...

Lenar

