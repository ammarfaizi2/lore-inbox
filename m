Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbSKLW04>; Tue, 12 Nov 2002 17:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266984AbSKLW04>; Tue, 12 Nov 2002 17:26:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53704 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266978AbSKLW0z>;
	Tue, 12 Nov 2002 17:26:55 -0500
Date: Tue, 12 Nov 2002 14:33:17 -0800 (PST)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: nivedita@w-nivedita.beaverton.ibm.com
To: folkert@vanheusden.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_v4_get_port?
Message-ID: <Pine.LNX.4.44.0211121431500.18229-100000@w-nivedita.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am I right that in net/ipv4/tcp_ipv4.c in function "tcp_v4_get_port" the
> portnumber for a new connection is generated? Because fiddling with that
> code seems to have no effect on the portnumbers generated for new
> connections.

What change are you making and which kernel are you making it in?

thanks,
Nivedita

