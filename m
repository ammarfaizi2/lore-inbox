Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUGYX4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUGYX4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 19:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGYX4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 19:56:21 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:46092 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S264609AbUGYX4U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 19:56:20 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: rpc@cafe4111.org
Subject: Re: 3C905 and ethtool
Date: Mon, 26 Jul 2004 01:56:14 +0200
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407251256.34500.cijoml@volny.cz> <200407251945.18055.rpc@cafe4111.org>
In-Reply-To: <200407251945.18055.rpc@cafe4111.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407260156.14896.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow :) 3years old todo :)
This is the way, how to make good os :)


Dne po 26. èervence 2004 01:45 Rob Couto napsal(a):
> drivers/net/3c59x.c:
> ....
>    LK1.1.15 6 June 2001 akpm
>     - Prevent double counting of received bytes (Lars Christensen)
>     - Add ethtool support (jgarzik)
>     - Add ....
>
> to my untrained eye, it looks like everything is there, so is there a
> parameter needed to access the card with ethtool? mii-tool reports they're
> doing the best rates they can anyway, so i suppose it's not a big deal. i'm
> thinking it's a chip-by-chip difference in the cards... and these
> particular cards have little to say.
