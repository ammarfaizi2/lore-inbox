Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266317AbUKATQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUKATQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267731AbUKATQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:16:28 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:4357 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S266317AbUKATQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:16:15 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: Johannes Stezenbach <js@convergence.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] HOWTO find oops location, v2
Date: Mon, 1 Nov 2004 20:16:00 +0100
User-Agent: KMail/1.7.1
References: <200408151439.31891.vda@port.imtp.ilyichevsk.odessa.ua> <20040817093034.GA14077@convergence.de>
In-Reply-To: <20040817093034.GA14077@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411012016.01027.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 of August 2004 11:30, Johannes Stezenbach wrote:

> Try: make EXTRA_CFLAGS="-g -Wa,-a,-ad   " ...
                                        ^ -fverbose-asm helps too.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
