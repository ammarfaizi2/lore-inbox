Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVEYPMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVEYPMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVEYPMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:12:13 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:64449 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262360AbVEYPMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:12:07 -0400
Message-Id: <429495E5.3020909@khandalf.com>
Date: Wed, 25 May 2005 17:12:37 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance (scheduler) --- QUESTION
References: <005801c560da$ec624f50$c800a8c0@mvista.com>
    <429407B6.1000105@yahoo.com.au>
    <20050525060919.GA25959@nietzsche.lynx.com>
    <4294228D.1040809@yahoo.com.au>
    <20050525092737.GA28976@nietzsche.lynx.com>
    <429490BD.6070606@yahoo.com.au>
In-Reply-To: <429490BD.6070606@yahoo.com.au>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: 0b76feb2ab8753d1ef66392fa46cc95f
X-Transmit-Date: Wednesday, 25 May 2005 17:12:47 +0200
X-Message-Uid: 0000b49cec9d005b0000000200000000429495ef00069abd00000001000a3dd2
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-03.tornado.cablecom.ch 32701; Body=1
	Fuz1=1 Fuz2=1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I havnt had time to look at thes patches so could someone
who has answer the following questions

- what is the increase in kernel overhead with the full
  patch enabled

- can the patch be configured IN/OUT and if so BUILD/RUN time

- I saw the mention of BUG catching, can someone elaborate

TIA

-- 
mit freundlichen Grüßen, Brian.

