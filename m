Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319608AbSIHN0p>; Sun, 8 Sep 2002 09:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319609AbSIHN0p>; Sun, 8 Sep 2002 09:26:45 -0400
Received: from christpuncher.kingsmeadefarm.com ([209.216.78.83]:39906 "HELO
	the-grudge.myip.org") by vger.kernel.org with SMTP
	id <S319608AbSIHN0o>; Sun, 8 Sep 2002 09:26:44 -0400
Message-ID: <1031491886.3d7b512ec36fc@webmail.kingsmeadefarm.com>
Date: Sun,  8 Sep 2002 09:31:26 -0400
From: Joe Kellner <jdk@kingsmeadefarm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clean before or after dep?
References: <Pine.LNX.4.44.0209072139470.21724-100000@redshift.mimosa.com> <1031490782.26902.4.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1031490782.26902.4.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 64.156.25.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

> 
> The "kernel-howto" has been badly broken for years. The world would
> actually be better without that document IMHO
> 


Currently, what is the proper way then? I know over the years the proper 
procedure has changed. make *config; make dep; make clean; make *Image;make 
modules?

-------------------------------------------------
sent via KingsMeade secure webmail http://www.kingsmeadefarm.com
