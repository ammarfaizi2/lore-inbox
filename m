Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288156AbSACDZb>; Wed, 2 Jan 2002 22:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288163AbSACDZL>; Wed, 2 Jan 2002 22:25:11 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:17356 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S288156AbSACDZH>; Wed, 2 Jan 2002 22:25:07 -0500
Message-Id: <200201030324.g033Ovj13057@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Jeff <piercejhsd009@earthlink.net>, nknight@pocketinet.com
Subject: Re: Who fixed via82cxxx_audio.c ?
Date: Thu, 3 Jan 2002 05:24:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <WHITExvWvqzAoa2JB1n000005b3@white.pocketinet.com> <3C28A640.9C9B8462@loewe-komp.de> <3C2B43FD.6E2961E0@earthlink.net>
In-Reply-To: <3C2B43FD.6E2961E0@earthlink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 December 2001 05:53 pm, Jeff wrote:
> Nicholas,
>
> Does the record work on your via82c686 sound?
...
>
> Using 2.4.16 kernel and via82cxxx_audio ver. 1.9.1
>

I just compiler and installed kernel-2.4.16-0.13 frpm redhat
rawhide. I'm using ASUS cuv4x with on-board sound (via 686).

Well, this fixed the mixer problems. I'm experimenting
with recordeing - with some success. 

Things don't work exactly as I expect but I have not
pinned any specific problem yet.

-- Itai
