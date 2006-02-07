Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWBGHGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWBGHGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWBGHGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:06:14 -0500
Received: from web37810.mail.mud.yahoo.com ([209.191.87.123]:37310 "HELO
	web37810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964950AbWBGHGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:06:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oCcL/lzrRgEouwrBHtXEf7w+wuoeKxaR490ehlT5l+KXCJOL18aQ45BaOSURwg3anCYojmW/9QToVaVehL2ZzeqRYqmtz4ZRwHpBylowUUfqKttLgvXf6JTQ4LiSYYn7uA7unnQKknFVYOmrHoRmTZ+w3ZAgDTdvnmi2KU0ZEpc=  ;
Message-ID: <20060207070611.63765.qmail@web37810.mail.mud.yahoo.com>
Date: Mon, 6 Feb 2006 23:06:11 -0800 (PST)
From: Grant Ian Hatamosa <grant_hatamosa@yahoo.com>
Subject: Fedora Core 2 with Linux 2.6.14.7 hangs when webcam attached thru HS USB hub
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wanted to know if anybody can show me how to resolve
an issue with my system.

I am having some problem if I attach an Intel webcam
(model CS330) through a high speed hub (forgot the
name and model of the hub). Once I got the webcam
enumerated and run an application, like gnomemeeting,
the system just hangs. I looked at /var/log/messages/
but it does not get me much clues even after I have
turned USB verbose messaging, as well as, spca5xx
messaging already ON. It kinda stopped in a middle of
a reg_write in the spca5xx system.

Any ideas?

Best regards,
Grant

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
