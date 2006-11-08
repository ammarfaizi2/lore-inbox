Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965548AbWKHKfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965548AbWKHKfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965563AbWKHKfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:35:51 -0500
Received: from qb-out-0506.google.com ([72.14.204.236]:40980 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965548AbWKHKfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:35:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=amjMlu2upexoi6y09Gw/x79EO78XmAU4F9COzbHXXYDwdWNi+AhMYcJyw1ZDSk6O6xE54lOzvngw66yqolqxxaFUm4Msr6bpbj2y8FkDcWSmHdV5ahFa2GtjGAOeaRnGkXV+WE74VC1hrwC6lvcjpv3K+7pGHRO0hMXLHxBUAaU=
Message-ID: <6c4c86470611080054r21f5c632u674da23bf3d1cc32@mail.gmail.com>
Date: Wed, 8 Nov 2006 09:54:16 +0100
From: "Wilco Beekhuizen" <wilcobeekhuizen@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
Cc: "Dave Jones" <davej@redhat.com>,
       "Sergio Monteiro Basto" <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162863274.11073.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	 <1162817254.5460.4.camel@localhost.localdomain>
	 <1162847625.10086.36.camel@localhost.localdomain>
	 <20061107012519.GC25719@redhat.com>
	 <1162863274.11073.41.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why was this changed in the stable kernel anyway, especially in a
micro-stability update? It seems to me it breaks more than it fixes.
