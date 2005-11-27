Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVK0OON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVK0OON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVK0OON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:14:13 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:28809 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751063AbVK0OON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:14:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QW64tw2JYw/hfUugIQi4kkhk1GZnlslmK59g6fp3kX3jKa55pS3trV1lPWdw0DI/Oz2tSZBqEWfpdZ0bOLJ/hnGy/+8tW5rvDycXrHU/H09bjaAqplAAmBYdB9xOOPpCodqRJ0R/dQ79eETGIlmS651tAtlQPdFwVbbKksvZ3ys=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: mingo@elte.hu
Subject: Re: 2.6.14-rt15 @x86_64UP: "sem_post: Invalid argument"
Date: Sun, 27 Nov 2005 15:17:18 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200511261140.47931.annabellesgarden@yahoo.de>
In-Reply-To: <200511261140.47931.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511271517.18931.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 26. November 2005 11:40 schrieb Karsten Wiese:
> I get loads of those messages since switching from rt12 to rt15.

fixed in rt20.

I've got an "io_apic cached" patch for x86_64 here,
that ticks since weeks on my UP. Interisting?

   danke,
   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
