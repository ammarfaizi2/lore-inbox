Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267422AbRGLD5i>; Wed, 11 Jul 2001 23:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbRGLD53>; Wed, 11 Jul 2001 23:57:29 -0400
Received: from f123.law8.hotmail.com ([216.33.241.123]:18697 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267422AbRGLD5J>;
	Wed, 11 Jul 2001 23:57:09 -0400
X-Originating-IP: [192.4.16.150]
Reply-To: jatin.shah@yale.edu
From: "Jatin Shah" <jatin_shah100@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Resource busy
Date: Wed, 11 Jul 2001 23:57:05 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F123WsJ4X0q1y9v2N3t00013f69@hotmail.com>
X-OriginalArrivalTime: 12 Jul 2001 03:57:06.0115 (UTC) FILETIME=[B75AA130:01C10A86]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have an application that uses an USB camera. This app is bit buggy and 
when it crashes (segmentation fault) it locks the devices so that the app 
always gets the message "Device or Resource Busy"(Thats error EBUSY). Note 
that app, mmaps device to memory.

        Now that app has crashed how do I release the device? rmmod on 
camera driver (or uhci) does not work.

Jatin
PS: Please cc me the response.
_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

