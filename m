Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422861AbWJNVOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWJNVOj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWJNVOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 17:14:39 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:59485 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422861AbWJNVOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 17:14:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=hDvapFtZ2oSqrI05smIe2XNyfWrcIpRpfcGUqKz3sQVaaWvYwEFwsNFkuomZuBTqfBR4QMiGgGaNqQGDPOoJ4UmIabD4ii3RTTgdIQ+DqPBqlm1Dh9x4kmv79cjzThYCcTNuVlE0Qmc44FgNCp28XvArvZ52BNnztE4dGVbuezo=  ;
In-Reply-To: <4530FC8E.7020504@comcast.net>
References: <4530570B.7030500@comcast.net> <20061014075625.GA30596@stusta.de> <4530FC8E.7020504@comcast.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kevin K <k_krieser@sbcglobal.net>
Subject: Re: Driver model.. expel legacy drivers?
Date: Sat, 14 Oct 2006 16:14:35 -0500
To: John Richard Moser <nigelenki@comcast.net>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 14, 2006, at 10:04 AM, John Richard Moser wrote:
> My math predicts that 2.6.57 (+39) will be 100M (in approximately 7
> years if you assume 1 kernel release every 2 months); 2.6.92 (+35)  
> will
> breech 200M; 2.6.117 (+25) will breech 300M; and 2.6.138 (+21)) will
> breech 400M.  That should suffice for predictions over the next 20  
> years
> based on this crude model.
>

Who knows.  By that time, CPU caches may be that size.  And hopefully  
tools are developed to an extent that they can automate cleanup.
