Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319429AbSIGAOD>; Fri, 6 Sep 2002 20:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319431AbSIGAOD>; Fri, 6 Sep 2002 20:14:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41106 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319429AbSIGAOD>;
	Fri, 6 Sep 2002 20:14:03 -0400
Message-ID: <1031357896.3d7945c875a7e@imap.linux.ibm.com>
Date: Fri,  6 Sep 2002 17:18:16 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: Troy Wilson <tcw@tempest.prismnet.com>
Cc: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <200209062356.g86Nu4Gk016944@tempest.prismnet.com>
In-Reply-To: <200209062356.g86Nu4Gk016944@tempest.prismnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Troy Wilson <tcw@tempest.prismnet.com>:

> > Do you have any stats from the hardware that could show
> > retransmits etc;

Troy,

Are tcp_sack, tcp_fack, tcp_dsack turned on?

thanks,
Nivedita


