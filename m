Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267217AbUBMVcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267227AbUBMVcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:32:03 -0500
Received: from palrel12.hp.com ([156.153.255.237]:53430 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S267217AbUBMVbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:31:35 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16429.16944.521739.223708@napali.hpl.hp.com>
Date: Fri, 13 Feb 2004 13:31:28 -0800
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org
Subject: Re: Kernel Cross Compiling
In-Reply-To: <20040213205743.GA30245@MAIL.13thfloor.at>
References: <20040213205743.GA30245@MAIL.13thfloor.at>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 13 Feb 2004 21:57:43 +0100, Herbert Poetzl <herbert@13thfloor.at> said:

  Herbert> I got all headers fixed, except for the ia64, which still
  Herbert> doesn't work

Something sounds wrong here. You shouldn't have to patch headers.

A recipe for building ia32->ia64 cross-toolchain on Debian can be
found here:

 http://www.gelato.unsw.edu.au/IA64wiki/CrossCompilation

	--david
