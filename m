Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWJ3NPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWJ3NPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWJ3NPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:15:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:27664 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964857AbWJ3NPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:15:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fn2+neDCQmIzfBTGcdGJfPj7Pw05JUB6tR8LAX8SOBJyA9jwNeuL0qmuGpqjTvTGlWMuJQAzAJ2lehZ8N6Prya3XvheIpjkLRVcQIdPUZ5zNMrGOyhAHmLbLqPU84RCirO7kpXAX8UuImPJp6l161DUiYJB+4jdRL7ASB+PcJ/U=
Message-ID: <1b270aae0610300515u502e5819g256c9de438d064f8@mail.gmail.com>
Date: Mon, 30 Oct 2006 14:15:42 +0100
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: user-space command "ipcs" seems broken on 2.6.18.1
In-Reply-To: <1b270aae0610300437u1529b5ddo5a365a06f16611c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0610300414u4175fec6i30a1396dde260ca1@mail.gmail.com>
	 <9a8748490610300432m45e560f8gdaeb951877e2532e@mail.gmail.com>
	 <1b270aae0610300437u1529b5ddo5a365a06f16611c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you identify the latest kernel where it works OK?

I can't reproduce that behaviour on another SMP machine with the same
kernel-config for 2.6.18.1 (only storage and network device drivers
differ).
The affected one is a production machine I can't use to test, and
furthermore the only one I've got of that series.

Has to wait until the weekend. Any remote clue so I know where to look?
Thanks,
M
