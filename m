Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbSIQKeg>; Tue, 17 Sep 2002 06:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264036AbSIQKeg>; Tue, 17 Sep 2002 06:34:36 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:21964 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S264035AbSIQKef>;
	Tue, 17 Sep 2002 06:34:35 -0400
Date: Tue, 17 Sep 2002 06:31:03 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <todd-lkml@osogrande.com>,
       <tcw@tempest.prismnet.com>, <netdev@oss.sgi.com>, <pfeather@cs.unm.edu>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020916.125211.82482173.davem@redhat.com>
Message-ID: <Pine.GSO.4.30.0209170622440.1371-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Sep 2002, David S. Miller wrote:

>    From: todd-lkml@osogrande.com
>    Date: Mon, 16 Sep 2002 08:16:47 -0600 (MDT)
>
>    are there any standards in progress to support this.
>
> Your question makes no sense, it is a hardware optimization
> of an existing standard.  The chip merely is told what flows
> exist and it concatenates TCP data from consequetive packets
> for that flow if they arrive in sequence.
>

Hrm. Again, the big Q:
How "thmart" is this NIC going to be (think congestion control and
the du-jour flavor).

cheers,
jamal

