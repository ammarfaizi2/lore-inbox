Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTJBWKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTJBWKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:10:36 -0400
Received: from [200.140.247.106] ([200.140.247.106]:4572 "EHLO
	marea.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263509AbTJBWKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:10:35 -0400
Message-ID: <1065132318.3f7ca11eb5c23@webmail.conectiva.com.br>
Date: Thu,  2 Oct 2003 19:05:18 -0300
From: acme@conectiva.com.br
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Net device error logging
References: <3F7C967F.A06A512E@us.ibm.com>
In-Reply-To: <3F7C967F.A06A512E@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
X-Originating-IP: 200.161.11.225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/netsyms.c is gone, please export that symbol just after its 
implementation. 
 
- Arnaldo 
 
 
