Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319432AbSIGAW6>; Fri, 6 Sep 2002 20:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319433AbSIGAW5>; Fri, 6 Sep 2002 20:22:57 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:1805 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S319432AbSIGAW5>; Fri, 6 Sep 2002 20:22:57 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200209070027.g870RXFc017282@tempest.prismnet.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <1031357896.3d7945c875a7e@imap.linux.ibm.com> "from Nivedita Singhvi
 at Sep 6, 2002 05:18:16 pm"
To: Nivedita Singhvi <niv@us.ibm.com>
Date: Fri, 6 Sep 2002 19:27:33 -0500 (CDT)
CC: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are tcp_sack, tcp_fack, tcp_dsack turned on?

  tcp_fack and tcp_dsack are on, tcp_sack is off.

- Troy


