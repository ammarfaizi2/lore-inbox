Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRJ2Ppp>; Mon, 29 Oct 2001 10:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJ2Ppf>; Mon, 29 Oct 2001 10:45:35 -0500
Received: from f22.law14.hotmail.com ([64.4.21.22]:56079 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275994AbRJ2PpV>;
	Mon, 29 Oct 2001 10:45:21 -0500
X-Originating-IP: [194.237.243.239]
From: "John Nilsson" <pzycrow@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Writing a driver for a pci busmaster ide controller, need tutoring.
Date: Mon, 29 Oct 2001 16:45:52 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F22YVWTE5XNKlXyC08X00015176@hotmail.com>
X-OriginalArrivalTime: 29 Oct 2001 15:45:52.0908 (UTC) FILETIME=[CA5304C0:01C16090]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably one of those RTFM and FAQ mails, but I'm desperate.

I have just recived the register specs for a chip called piccolo_s, this is 
a bus master ide controller found it some older toshiba laptops.
As this is my first atempt to write a driver I find my self not really 
having the knowhow to do this. And it is extremely hard to find good 
tutorials on the subject =)
So please if anyone find the time and motivation, would you write me one?
Mabey not but if you were to send me all you know on this topic I might be 
able to puzzle the bits and pieces together and write this driver.
It would be easier for me to just let one of you guys write this driver, but 
if noone is in any hurry I would find this a great learning experience, and 
fun to ;)

I've found one good documet, "PCI Managment in Linux 2.2 by Alan Cox", but I 
feel this isn't enough. Alan? would you please give me some pointers?

My experience is not great, I can find my way arond C. I have some basic 
knowlege of how a computer works (apparantly not enough), but I acctually do 
not know what this driver is supposed to do, other than setting som 
registers.
Also is there a way to use /proc to find devices that don't have a driver? 
Or is it just not there?
/John Nilsson
If you dont feel like sending me private mails, pleas CC me :)

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

