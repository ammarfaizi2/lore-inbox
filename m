Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUH1A3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUH1A3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUH1A0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:26:03 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:24206 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267880AbUH1AWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:22:54 -0400
Date: Sat, 28 Aug 2004 01:22:32 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
cc: Jesper Juhl <juhl-lkml@dif.dk>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
In-Reply-To: <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
Message-ID: <Pine.LNX.4.61.0408280114460.2441@fogarty.jakma.org>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
 <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost>
 <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting comment on /.:

http://linux.slashdot.org/comments.pl?sid=119578&cid=10089410

>From the LavaRND people. Apparently images produced with the binary 
pcwx portion loaded (full-sized frame) had *less* entropy than the 
smaller images produced without. Hence they speculate that the 
function of the binary pcwx part is actually to interpolate the 
160x120 image to the bigger 640x480 size, and has little to do with 
hardware..

allegedly..

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
"Let's show this prehistoric bitch how we do things downtown!"
-- The Ghostbusters
