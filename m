Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUGYXqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUGYXqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 19:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUGYXqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 19:46:23 -0400
Received: from ms-smtp-01-smtplb.ohiordc.rr.com ([65.24.5.135]:52960 "EHLO
	ms-smtp-01-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264635AbUGYXqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 19:46:07 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
Date: Sun, 25 Jul 2004 19:45:18 -0400
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <20040725102700.GN18676@lug-owl.de> <200407251256.34500.cijoml@volny.cz>
In-Reply-To: <200407251256.34500.cijoml@volny.cz>
Cc: cijoml@volny.cz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251945.18055.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/3c59x.c:
....
   LK1.1.15 6 June 2001 akpm
    - Prevent double counting of received bytes (Lars Christensen)
    - Add ethtool support (jgarzik)
    - Add ....

to my untrained eye, it looks like everything is there, so is there a 
parameter needed to access the card with ethtool? mii-tool reports they're 
doing the best rates they can anyway, so i suppose it's not a big deal. i'm 
thinking it's a chip-by-chip difference in the cards... and these particular 
cards have little to say.

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
    -unless Internet Explorer is involved.
--
