Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbTAFC7j>; Sun, 5 Jan 2003 21:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTAFC7j>; Sun, 5 Jan 2003 21:59:39 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:9481 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265851AbTAFC7j>; Sun, 5 Jan 2003 21:59:39 -0500
Date: Sun, 05 Jan 2003 20:08:10 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: David Lang <david.lang@digitalinsight.com>
cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Message-ID: <446440000.1041822490@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.44.0301051838180.23962-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0301051838180.23962-100000@dlang.diginsite.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get the same 'failed memory mapped' error (and the inability to run 2.5
> kernels)

The messages and the inability to run 2.5 kernels are not related.  The
diagnostic prints and the driver falls back to using the "safe" PIO method.

--
Justin
