Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbSJDPV1>; Fri, 4 Oct 2002 11:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSJDPVU>; Fri, 4 Oct 2002 11:21:20 -0400
Received: from [213.228.128.91] ([213.228.128.91]:29664 "HELO
	front3.netvisao.pt") by vger.kernel.org with SMTP
	id <S262035AbSJDPU1>; Fri, 4 Oct 2002 11:20:27 -0400
Date: Fri, 4 Oct 2002 16:32:38 +0100
From: "Paulo Andre'" <fscked@netvisao.pt>
To: sander79@wanadoo.nl
Cc: sander@kamphuis.dyndns.org, linux-kernel@vger.kernel.org
Subject: Re: bug report
Message-Id: <20021004163238.651a998c.fscked@netvisao.pt>
In-Reply-To: <200210041701.21475.sander@kamphuis.dyndns.org>
References: <200210041701.21475.sander@kamphuis.dyndns.org>
Organization: Tool Enterprises
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002 17:01:21 +0200
Sander Kamphuis <sander@kamphuis.dyndns.org> wrote:

> *This message was transferred with a trial version of CommuniGate(tm)
> Pro* error after compiling kernel 2.4.20pre8 after applying the patch
> pre7 -> pre8 the following error occures after running 'make bzImage'

make clean dep prior to make bzImage

	-- Paulo
