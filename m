Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTBDVoM>; Tue, 4 Feb 2003 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTBDVoL>; Tue, 4 Feb 2003 16:44:11 -0500
Received: from [81.2.122.30] ([81.2.122.30]:60937 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267467AbTBDVoK>;
	Tue, 4 Feb 2003 16:44:10 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302042154.h14LsYlQ003240@darkstar.example.net>
Subject: Re: gcc 2.95 vs 3.21 performance
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 4 Feb 2003 21:54:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b1pbt8$2ll$1@penguin.transmeta.com> from "Linus Torvalds" at Feb 04, 2003 09:38:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd love to see a small - and fast - C compiler, and I'd be willing to
> make kernel changes to make it work with it.  

How IA-32 centric would your prefered compiler choice be?  In other
words, if a small and fast C compiler turns up, which lacks support
for some currently ported to architectures, are you likely to
encourage kernel changes which will make it difficult for the other
architectures that have to stay with GCC to keep up?

John.
