Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTBCW2K>; Mon, 3 Feb 2003 17:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTBCW2K>; Mon, 3 Feb 2003 17:28:10 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:59079 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267030AbTBCW2J>;
	Mon, 3 Feb 2003 17:28:09 -0500
From: b_adlakha@softhome.net
To: linux-kernel@vger.kernel.org
Subject: cannot set tty to ppp discipline on 2.5.59
Date: Mon, 03 Feb 2003 15:37:38 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.80.157]
Message-ID: <courier.3E3EEF32.000048E2@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get pppd to work on 2.5.59, it dies with :
"couldn't set tty to ppp discipline" 

I have everything compiled in the kernel (ppp_generic, ppp_async and the 
compression stuff) 

This only happens with the 2.5.59 kernel, not the 2.4.20 kernel...what am I 
doing wrong? 

Thanks for reading/replying.
