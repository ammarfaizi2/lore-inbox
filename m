Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTHZPXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbTHZPXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:23:18 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:52675 "EHLO
	mwinf0102.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261158AbTHZPXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:23:17 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: "Stuart MacDonald" <stuartm@connecttech.com>,
       "'Russell King'" <rmk@arm.linux.org.uk>
Subject: Re: Reading accurate size of recepts from serial port
Date: Tue, 26 Aug 2003 17:23:04 +0200
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>
References: <005c01c36bdd$8ae58d30$294b82ce@stuartm>
In-Reply-To: <005c01c36bdd$8ae58d30$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308261723.04683.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 26 Août 2003 16:22, Stuart MacDonald a écrit :
> I may be mistaken, but I believe that Windows serial drivers work the
> same way; so whatever you meant by your previous comment that you can
> get what you want under windows, either you can get the same thing
> under linux, or windows doesn't behave like you think it does.
I actually don't know how it works, because I didn't contrive it (I can only 
rely on what has been told to me by the people whom has done it). I'm only in 
charge of porting it to Linux.
Anyway, I'm on the way to another solution (by using some property of CCSDS 
segments, and see what happens).
-- 
Laurent Hugé.

