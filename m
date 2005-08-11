Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVHKACg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVHKACg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVHKACf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:02:35 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:11395 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964851AbVHKACf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:02:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jY+zov8evHWEUWgNvhQjmHNrtxlxWTswDwHhcP0FX0MKSCuTb7rwZ0BdLrepFGJfaNtmTHiKr480/uh1pbcXR4JDwAUyLI67DVgMWry9ZGqRwZ6/iVsbvhAYwYdDJJCiwl4eYd8+RJNoA1/Bkrm0x/r3xdomlKICx7D+v+uObsI=
Message-ID: <d4757e6005081017024c3bf3fd@mail.gmail.com>
Date: Wed, 10 Aug 2005 20:02:33 -0400
From: Joe <joecool1029@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: remove support for gcc < 3.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <42FA5848.809@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050731222606.GL3608@stusta.de>
	 <20050731.153631.70217457.davem@davemloft.net> <42FA5848.809@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm for its removal. As for the gcc project "losing its way" consider
that 3.4 has quite matured and also has much smaller binary size from
3.3. 4.0 however is still too early in its development to come close
to surpassing 3.4.

With all the changes and deprications it seems pointless to have to
maintain extra code so 3 people can use an obsolete compiler.
Something more recent like 3.4 should be used as a bench.

Just my two cents.
