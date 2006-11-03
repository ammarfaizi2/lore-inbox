Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWKCHZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWKCHZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 02:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbWKCHZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 02:25:05 -0500
Received: from web36711.mail.mud.yahoo.com ([209.191.85.45]:46720 "HELO
	web36711.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751963AbWKCHZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 02:25:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=a2XCPGpJwP8h9We3370ctDv0sL3i+cX2oc2VJYVXN1kvifyu86arzIo04BPn5qtLBWY1DacMaA48BS1Y2Oa/RfJ2/Fpw9yw4BwDQGZu9kLIZ/UGgnYEI66auqvTREQVGt00Z8I782M/k5de8KFSjuj1Pgocu0t9jNLGjq0dro8Q=  ;
Message-ID: <20061103072501.60620.qmail@web36711.mail.mud.yahoo.com>
Date: Thu, 2 Nov 2006 23:25:01 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: 2.6.19-rc4 - tifm_7xx1 does not work after suspend-to-disk
To: Pierre Ossman <drzeus-mmc@drzeus.cx>,
       Fabio Comolli <fabio.comolli@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <454AE285.4070504@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking into this stuff lately, and it's appears to be something complex. I couldn't get it
to crush on git-head, but I've got write corruptions every now and then. And suspend is totally
untested at the moment.

I'm currently trying to fix this.



 
____________________________________________________________________________________
We have the perfect Group for you. Check out the handy changes to Yahoo! Groups 
(http://groups.yahoo.com)

