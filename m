Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVIQRdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVIQRdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 13:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVIQRdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 13:33:25 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:13537 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751167AbVIQRdZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 13:33:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCXCx8f4xLI28xld72t//knisHy9BC8A9RVsj+I5AA88qypMAd0QkJXMZuTpfGYrznKuKq8vcQ5Wk5DFccNoJBwXo3u/wU96NlHqZu3zqZSd7EuqL3y25wFoFiOkQxwAGIj7YxqpnsCQPIHvqTo+L/adnLnL/ET4K9uFSbFWJQg=
Message-ID: <6bffcb0e05091710335fcda6eb@mail.gmail.com>
Date: Sat, 17 Sep 2005 19:33:24 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Why don't we separate menuconfig from the kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m364szk426.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m364szk426.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17 Sep 2005 19:16:33 +0200, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Hi,
> 
> A number of packages (e.g., busybox) use some, more or less broken,
> version of menuconfig. Would it make sense to move menuconfig to
> a separate well-defined package?
> 
> Nooo? Why not?
> --
> Krzysztof Halasa

menuconfig is _part_ of kernel configuration system.

Regards,
Michal Piotrowski
