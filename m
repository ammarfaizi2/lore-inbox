Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275208AbRJAQUv>; Mon, 1 Oct 2001 12:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275210AbRJAQUl>; Mon, 1 Oct 2001 12:20:41 -0400
Received: from t2.redhat.com ([199.183.24.243]:22771 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S275208AbRJAQUY>; Mon, 1 Oct 2001 12:20:24 -0400
Message-ID: <3BB897DB.C34A28B9@redhat.com>
Date: Mon, 01 Oct 2001 17:20:43 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethX <-> module matching from userspace?
In-Reply-To: <Pine.GSO.4.30.0110011121080.7669-100000@balu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:
> 
> Hi all,
> 
> Is there a way that i could get which module registered which ethX
> interface, from userspace? I would really like to see it.
>

ethtool -i eth0
