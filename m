Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSGYOn0>; Thu, 25 Jul 2002 10:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSGYOn0>; Thu, 25 Jul 2002 10:43:26 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3826 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315275AbSGYOnZ>; Thu, 25 Jul 2002 10:43:25 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020725161630.A23807@innova.no> 
References: <20020725161630.A23807@innova.no> 
To: Erlend Aasland <erlend-a@innova.no>
Cc: Patchmonkey <trivial@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
       jffs-dev <jffs-dev@axis.com>
Subject: Re: [TRIVIAL][PATCH 2.5] Fix JFFS when procfs is not enabled 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jul 2002 15:46:14 +0100
Message-ID: <8627.1027608374@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


erlend-a@innova.no said:
>  Here's a trivial one. Only ask for procfs support when procfs is
> enabled. 

S'broken. Don't apply it. Working out why is left as an exercise for the 
reader. Google is your friend.

--
dwmw2


