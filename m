Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbTCaRPZ>; Mon, 31 Mar 2003 12:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261728AbTCaRPZ>; Mon, 31 Mar 2003 12:15:25 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5636 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261726AbTCaRPX>; Mon, 31 Mar 2003 12:15:23 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303311729.h2VHTNtn000273@81-2-122-30.bradfords.org.uk>
Subject: Re: I compiled the kernel but it doesn't do any thing, its a bit like typing "halt".
To: dean.mcewan@eudoramail.com
Date: Mon, 31 Mar 2003 18:29:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CJMOJMHEJLJPPBAA@whowhere.com> from "Dean McEwan" at Mar 31, 2003 03:58:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course its probably something to do with init,
> but does anyone know whats going wrong?

Boot with init=/bin/sh and see what happens.

> whats system.map actually for

Decoding numerical addresses in to function names.

John.
