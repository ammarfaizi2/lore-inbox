Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTFYNul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 09:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTFYNul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 09:50:41 -0400
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:11142 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP id S264507AbTFYNuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 09:50:40 -0400
Message-Id: <200306251404.AA00005@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Wed, 25 Jun 2003 23:04:42 +0900
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.73 compile error
In-Reply-To: <20030624163548.GA3914@kroah.com>
References: <20030624163548.GA3914@kroah.com>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>> I update to linux-2.5.73 from linux-2.5.72.
>> compile error occured.
>
>Search the archives for the patch, or just enable CONFIG_HOTPLUG
>

I update to 2.5.73 from 2.5.72, and I used a same .config parameter.
but compile error occured.
Is CONFIG_HOTPLUG a mandatory parameter? I think it is not.

Now, I update to 2.5.73 + bk3, it compile and boot up fine.

thank you.

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
