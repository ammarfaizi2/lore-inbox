Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031218AbWKURBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031218AbWKURBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031214AbWKURBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:01:12 -0500
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:18050 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1031202AbWKURBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:01:08 -0500
Message-ID: <45633EDF.3050309@fr.ibm.com>
Date: Tue, 21 Nov 2006 19:01:03 +0100
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Cedric Le Goater <clg@fr.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Dmitry Mishin <dim@sw.ru>,
       netdev@vger.kernel.org
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <4563046B.6040909@sw.ru>
In-Reply-To: <4563046B.6040909@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Cedric,
> 
> Dmitry Mishin and Daniel Lezcano are working together on the full
> network namespace incorporating both needs of OpenVZ and VServer/IBM.
> 
> Thanks,
> Kirill

Kirill,

We will need this framework to move the network isolation code to the 
ns_proxy/net_namespace structure. So if Cedric gives us a empty 
framework it is fine, except if someone does not agree with it...

   -- Daniel.
