Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTAHQBA>; Wed, 8 Jan 2003 11:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267507AbTAHQBA>; Wed, 8 Jan 2003 11:01:00 -0500
Received: from [81.2.122.30] ([81.2.122.30]:54277 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267375AbTAHQA7>;
	Wed, 8 Jan 2003 11:00:59 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301081609.h08G929Q001835@darkstar.example.net>
Subject: Re: [PATCH][TRIVIAL] menuconfig color sanity
To: jeff-lk@gerard.st
Date: Wed, 8 Jan 2003 16:09:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030108155623.GA26882@kanoe.ludicrus.net> from "Joshua M. Kwan" at Jan 08, 2003 07:56:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> using yellow and green text with a "white" background in
> menuconfig works all right on console

I have seen the original problem, where the first letter is not
visible in an xterm.

Just add a colour/monochrome toggle, that way people can choose which
they prefer.

John.
