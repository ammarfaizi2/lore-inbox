Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264239AbTCXPGN>; Mon, 24 Mar 2003 10:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264243AbTCXPGN>; Mon, 24 Mar 2003 10:06:13 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.29]:29056 "EHLO
	mwinf0202.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264239AbTCXPGL>; Mon, 24 Mar 2003 10:06:11 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Spang Oliver <oliver.spang@siemens.com>,
       "'pbadari@us.ibm.com'" <pbadari@us.ibm.com>
Subject: Re: 2.5.64 ttyS problem ?
Date: Mon, 24 Mar 2003 16:17:01 +0100
User-Agent: KMail/1.5.1
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4675@BSL203E>
In-Reply-To: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4675@BSL203E>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303241617.01952.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> has anyone another solution? I tried 2.5.62 to 2.5.65, same result.

Is this the no "serial" module problem?  It seems to have been renamed
"8250", but not everything knows that yet...

Duncan.
