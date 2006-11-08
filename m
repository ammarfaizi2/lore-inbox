Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965903AbWKHOz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965903AbWKHOz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965905AbWKHOz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:55:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:59078 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965903AbWKHOz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:55:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fSAaulCxBA9s2u+aYo5cVM2N9QNK0y/nRLJ3ggEjU/ByW62mpZdm8cnlHY7Jc3vg0lbZhZZSGX8UW1AFRTW9ucZUrEukx/oYaetJGsAnE4UYvBdSH59rsc+K++dWLMEFiqIVnQnr0Yy7cUeefo9Hh5J2h7ahyQNiDNE/q6+bsBY=
Message-ID: <6c4c86470611080655s22fc26c8xe23b4f6d37dc4b6d@mail.gmail.com>
Date: Wed, 8 Nov 2006 15:55:25 +0100
From: "Wilco Beekhuizen" <wilcobeekhuizen@gmail.com>
To: "Sergio Monteiro Basto" <sergio@sergiomb.no-ip.org>
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Dave Jones" <davej@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1162989792.2693.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	 <1162817254.5460.4.camel@localhost.localdomain>
	 <1162847625.10086.36.camel@localhost.localdomain>
	 <20061107012519.GC25719@redhat.com>
	 <1162863274.11073.41.camel@localhost.localdomain>
	 <6c4c86470611080054r21f5c632u674da23bf3d1cc32@mail.gmail.com>
	 <1162989792.2693.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes your patch works fine but I saw some objections from Alan.
