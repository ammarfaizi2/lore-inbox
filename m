Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSHLOZR>; Mon, 12 Aug 2002 10:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSHLOZR>; Mon, 12 Aug 2002 10:25:17 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:17135 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318045AbSHLOZQ>; Mon, 12 Aug 2002 10:25:16 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1716.1029124644@kao2.melbourne.sgi.com> 
References: <1716.1029124644@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@ocs.com.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 2002 15:28:57 +0100
Message-ID: <5839.1029162537@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  Untested, against 2.5.31.  It would be better to -Uunix globally but
> one header depends on it, drivers/message/fusion/lsi/mpi_type.h. 

/me looks... Urgh. Let it break.


--
dwmw2


