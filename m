Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSIAWIt>; Sun, 1 Sep 2002 18:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIAWIt>; Sun, 1 Sep 2002 18:08:49 -0400
Received: from sisko.nothing-on.tv ([213.208.99.114]:61584 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S318136AbSIAWIs>;
	Sun, 1 Sep 2002 18:08:48 -0400
Message-ID: <3D7291BB.1010004@nothing-on.tv>
Date: Sun, 01 Sep 2002 23:16:27 +0100
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in pl2303 driver
References: <3D7117D3.5080100@nothing-on.tv> <20020901005124.GA15259@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Razor-id: cf4cd8199af2c47f7af7342da25824019f9a6479
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A clue perhaps?  I switch from the uhci to the usb-uhci driver and the 
oops stopped happening (there were a couple of make mrproper/rebuilds in 
between too).

Tony

