Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJPWt7>; Wed, 16 Oct 2002 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSJPWt7>; Wed, 16 Oct 2002 18:49:59 -0400
Received: from services.cam.org ([198.73.180.252]:11198 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261442AbSJPWt7>;
	Wed, 16 Oct 2002 18:49:59 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: 2.5.43-mm1: KDE (3.1 beta2) do not start anymore
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Reply-To: tomlins@cam.org
Date: Wed, 16 Oct 2002 18:50:43 -0400
References: <200210162327.53701.Dieter.Nuetzel@hamburg.de>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <20021016225043.4A3732FBBA@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

> Nothing in the logs.
> But maybe (short before) sound initialization.
> Could it be "shared page table" related, too?
> 
> W'll try that tomorrow.

Kde 3.0 has never been able to start here when shared page tables have
been enabled in an mm kernel.  Still some cleanups and debugging to do 
it would seem.

Ed Tomlinson
