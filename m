Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271216AbRHOPJG>; Wed, 15 Aug 2001 11:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271211AbRHOPI4>; Wed, 15 Aug 2001 11:08:56 -0400
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:12551 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271216AbRHOPIq>; Wed, 15 Aug 2001 11:08:46 -0400
Date: Wed, 15 Aug 2001 16:07:50 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: linux-kernel@vger.kernel.org
Subject: /dev/random in 2.4.6
Message-ID: <Pine.LNX.4.21.0108151605180.2107-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Until recently I've been using the 2.2.16 kernel on Cobalt Qube 3's, but
I've just upgraded to 2.4.6.  Since there's no mouse, keyboard, etc, there
isn't much entropy data.  I had no problem getting plenty of data from
/dev/random under 2.2, but under 2.4.6 there seems to be a distinct lack
of data - it takes absolutely ages to extract about 256 bytes from it
(whereas under 2.2 it was relatively quick).  Has there been a major
change in the way the random number generator works under 2.4?

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


