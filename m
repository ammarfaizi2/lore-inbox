Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263292AbSIPW64>; Mon, 16 Sep 2002 18:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbSIPW64>; Mon, 16 Sep 2002 18:58:56 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:28402
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263292AbSIPW64>; Mon, 16 Sep 2002 18:58:56 -0400
Subject: Re: Problem:  RFC1166 addressing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: tomc@teamics.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>
References: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Sep 2002 00:06:34 +0100
Message-Id: <1032217594.2906.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 17:50, tomc@teamics.com wrote:
>  Linux does not enforce this.  I have uncovered some users using this
> function to attempt to circumvent the firewall.  I am able to "create" 127
> network traffic as follows:

If you choose to configure that way they yes you can. Since any other
box on the net can also send/received 127.* packets make sure your
firewall is right 8)

