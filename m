Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271418AbRHXNRv>; Fri, 24 Aug 2001 09:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271370AbRHXNRl>; Fri, 24 Aug 2001 09:17:41 -0400
Received: from t2.redhat.com ([199.183.24.243]:12274 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271006AbRHXNRc>; Fri, 24 Aug 2001 09:17:32 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <6208.998658929@ocs3.ocs-net> 
In-Reply-To: <6208.998658929@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: macro conflict 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2001 14:17:38 +0100
Message-ID: <16800.998659058@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  Did you try that?  Firstly typeof() is only defined in declaration
> context, it gets an error when used in an expression.  Secondly
> typeof() is not expanded by cpp so the stringify tricks do not work.
> typeof(x) is handled by cc, not cpp. 

No. It's far too silly for me to have actually tried it :)

--
dwmw2


