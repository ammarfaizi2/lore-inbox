Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282955AbRLEQAM>; Wed, 5 Dec 2001 11:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283443AbRLEQAB>; Wed, 5 Dec 2001 11:00:01 -0500
Received: from web20207.mail.yahoo.com ([216.136.226.62]:5637 "HELO
	web20207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282955AbRLEP7v>; Wed, 5 Dec 2001 10:59:51 -0500
Message-ID: <20011205155950.68336.qmail@web20207.mail.yahoo.com>
Date: Wed, 5 Dec 2001 10:59:50 -0500 (EST)
From: Michael Zhu <apiggyjj@yahoo.ca>
Reply-To: apiggyjj@yahoo.ca
Subject: Layered  modularization
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, does anyone know how to implement a layered
modularization in Linux?

I've read Alessandro Rubini's book "Linux device
driver". In Chapter 2 of his book he mentioned some
information about stacked modules. But not enough to
develop a Layered modularization. 

Now I need to write a hook module which will hook the
reading/writing operation of /dev/fd0. That means I
want to make a intermediate driver which layers above
or below the driver of /dev/fd0. 

It just like a filter driver in Windows platform.

Any idea will be appreciated.

Best regards,

Michael

______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
