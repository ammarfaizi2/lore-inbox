Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270991AbTHKElM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270995AbTHKElM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:41:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:2216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270991AbTHKElL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:41:11 -0400
Message-ID: <34268.4.4.25.4.1060576870.squirrel@www.osdl.org>
Date: Sun, 10 Aug 2003 21:41:10 -0700 (PDT)
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts seems correct
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rml@tech9.net>
In-Reply-To: <1060576517.684.47.camel@localhost>
References: <1060572792.1113.10.camel@boobies.awol.org>
        <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>
        <1060574873.684.41.camel@localhost>
        <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>
        <1060576517.684.47.camel@localhost>
X-Priority: 3
Importance: Normal
Cc: <cmrivera@ufl.edu>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2003-08-10 at 21:33, Randy.Dunlap wrote:
>
>> Ugh-ly?  We can move it to sysfs and then change the file format to
>> intnum:count pairs (e.g.).
>
> But then how is it different from /proc/interrupts ?

Um, your turn.

~Randy



