Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292751AbSBZT1P>; Tue, 26 Feb 2002 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292752AbSBZT1B>; Tue, 26 Feb 2002 14:27:01 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:5030 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292751AbSBZT0t>;
	Tue, 26 Feb 2002 14:26:49 -0500
Date: Tue, 26 Feb 2002 20:26:39 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Tulika Pradhan <tulikapradhan@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: frame relay on linux
Message-ID: <20020226202639.A17865@fafner.intra.cogenit.fr>
In-Reply-To: <LAW2-F51Hprp5yLZ86B00000eef@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <LAW2-F51Hprp5yLZ86B00000eef@hotmail.com>; from tulikapradhan@hotmail.com on Tue, Feb 26, 2002 at 12:47:12PM +0000
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tulika Pradhan <tulikapradhan@hotmail.com> :
[...]
> i want to develop frame relay stack for linux. what is the procedure if i 
> want to add this effort to the standard linux code and future versions.
> this would be different from the rfc1490 that is currently implemented in 
> linux. i would like to develop fr on linux - pvc and svc implementing Q.922 
> core and Q.933 for signalling.

Krzysztof Halasa's recent work may be an useful framework. Search last
month archive for "HDLC".

-- 
Ueimor
