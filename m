Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWFTHuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWFTHuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWFTHuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:50:07 -0400
Received: from web52906.mail.yahoo.com ([206.190.49.16]:15481 "HELO
	web52906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965144AbWFTHuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:50:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LTH9JpA6L8OfMUKlgjvlo6qP6MRCP7Yh0g8aaoZ1ecWsLjylL94SGIwnyoGKNRvqb98EnzmXe/WnQRReTNDPsCY8Fy1KlqXVGbx2JPUMGsYscfZQLsm99oTl7RceIiuu+7vOLjvtyfJnYOcAmFq5kmr8hD0cI/fI+dAdE77IyzY=  ;
Message-ID: <20060620075004.85981.qmail@web52906.mail.yahoo.com>
Date: Tue, 20 Jun 2006 08:50:04 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.17: IRQ handler mismatch in serial code?
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
In-Reply-To: <20060620010011.GA25527@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Adam Belay <ambx1@neo.rr.com> wrote:
> Yes, if a driver is available for the device, it will enable it regardless of
> the initial state.  Most manual BIOS configuration options don't actually
> disable the device in the commonly understood sense.  Rather, they tell the
> BIOS not to waste any time configuring the device, as the operating system
> is fully capable of doing so.  On operating systems that aren't PnP capable
> these options might have a greater effect.

OK, but I really do need that IRQ for the network card, and don't need that serial device on the
motherboard. So how can I tell Linux not to activate it, please?

Thanks,
Chris



	
	
		
___________________________________________________________ 
All new Yahoo! Mail "The new Interface is stunning in its simplicity and ease of use." - PC Magazine 
http://uk.docs.yahoo.com/nowyoucan.html
