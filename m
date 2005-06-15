Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFOTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFOTZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFOTZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:25:40 -0400
Received: from web51809.mail.yahoo.com ([206.190.38.240]:60337 "HELO
	web51809.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261467AbVFOTZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:25:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fyoRvQ97yBSGpIUh2vzCse44yCCvYnJ8obw0xX5/YkX56fogTt1Xl4LoAtW8WEkp1WcZoBnOXhjRXBbAHMWulYQ39vNKkDiMIxr7XOJeinNBAmUuPoXxo/Z13hTwxH84lyhgvj0gP7ee7QRsXcKM2L+NqydBpnC3fbryAzzeTiI=  ;
Message-ID: <20050615192534.35702.qmail@web51809.mail.yahoo.com>
Date: Wed, 15 Jun 2005 12:25:33 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: lib unwind
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all!

Does anyone know if there is an unwinding library for
user level apps available somewhere for amd64 linux?

I have a simple unwinder that I wrote that just grabs
the fp and steps through looking for symbols, however,
I can not get it work on amd64 platform (my trace gets
lost when it enters a sig handler).

I have searched around and found one for itanic, but
nothing else.

TIA!
Phy

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
