Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTGUHTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269269AbTGUHTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:19:40 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19329 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263894AbTGUHTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:19:40 -0400
Date: Mon, 21 Jul 2003 08:44:30 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307210744.h6L7iUDW000468@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: Problems contacting Linus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some of my mails to Linus return with:
>
> This is the Internet on Line ESMTP server program at host
> smtp-out1.iol.cz.
>
> I'm sorry to have to inform you that the message returned
> below could not be delivered to one or more destinations.
>
> For further assistance, please send mail to <postmaster>
>
> If you do so, please include this problem report. You can
> delete your own text from the message returned below.
>
>                         The Internet on Line ESMTP server program
>
> <torvalds@osdl.com>: host mail.goweb.com[211.174.63.240] said: 550 5.7.1
>     <torvalds@osdl.com>... Relaying denied. Proper authentication required. (in
>     reply to RCPT TO command)
>
> Anyone else seen that? What is the problem?

The problem is reproducable with:

http://vger.kernel.org/mxverify.html

John.
