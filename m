Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319764AbSILRXv>; Thu, 12 Sep 2002 13:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319765AbSILRXv>; Thu, 12 Sep 2002 13:23:51 -0400
Received: from christpuncher.kingsmeadefarm.com ([209.216.78.83]:52956 "HELO
	the-grudge.myip.org") by vger.kernel.org with SMTP
	id <S319764AbSILRXu>; Thu, 12 Sep 2002 13:23:50 -0400
Message-ID: <1031851720.3d80cec864630@webmail>
Date: Thu, 12 Sep 2002 13:28:40 -0400
From: Joe Kellner <jdk@kingsmeadefarm.com>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS?
References: <Pine.LNX.4.44.0209121104520.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209121104520.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 192.168.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thunder from the hill <thunder@lightweight.ods.org>:

> Hi,
> 
> On Thu, 12 Sep 2002 jbradford@dial.pipex.com wrote:
> > But Linux doesn't crash...  :-)
> 
> I'm running 2.4.19-rc5-aa1 on reiserfs on some twenty workstations, 
> neither of which ever crashed...
> 



Alot of hosting companies employ the "pull the plug" method of solving problems.
This isnt good on non journaling filesystems. (It's not good period, but thats
not going to change anytime soon).

-------------------------------------------------
sent via KingsMeade secure webmail http://www.kingsmeadefarm.com
