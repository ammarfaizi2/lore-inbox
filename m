Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271882AbRH2DgT>; Tue, 28 Aug 2001 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271889AbRH2DgJ>; Tue, 28 Aug 2001 23:36:09 -0400
Received: from juicer03.bigpond.com ([139.134.6.79]:32726 "EHLO
	mailin6.bigpond.com") by vger.kernel.org with ESMTP
	id <S271882AbRH2DgB>; Tue, 28 Aug 2001 23:36:01 -0400
Message-Id: <200108290336.f7T3aCIG002344@ADSL-Server.davsoft.com.au>
Content-Type: text/plain; charset=US-ASCII
From: David Findlay <david_j_findlay@yahoo.com.au>
Organization: Davsoft
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.4.9: Joydev module has incorrect version number
Date: Wed, 29 Aug 2001 13:35:34 +1000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using kernel 2.4.9. All the joystick stuff is in using the M options. 
When going modprobe joydev it can't find it. When using insmod to specifiy 
the exact name of the file, it says that it can't find the correct kernel 
version.

I'd also like to ask for 2.6 to have a feature that will automatically detect 
all hardware, and load the correct drivers. I'm sick of having to do all 
sorts of stuff to get hardware to go. Why can't it just work? Thanks,

David

P.S. I'm not subscribed, could you please CC your response to me, thanks.
