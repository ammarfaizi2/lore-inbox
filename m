Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUJBThl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUJBThl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUJBThl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:37:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57481 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267518AbUJBThj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:37:39 -0400
Subject: Re: [PATCH] AES x86-64-asm impl.
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Bohrer <Florian.Bohrer@t-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041002195304.79d7a059.Florian.Bohrer@t-online.de>
References: <20041002195304.79d7a059.Florian.Bohrer@t-online.de>
Content-Type: text/plain
Message-Id: <1096745858.5845.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 15:37:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-02 at 13:53, Florian Bohrer wrote:
> hi,
> 
> this is my first public kernel patch. it is an x86_64 asm optimized version of AES for the 
> crypto-framework. the patch is against 2.6.9-rc2-mm1 but should work with other 
> versions too. 
> 
> 
> the asm-code is from Jari Ruusu (loop-aes).
> the org. glue-code is from Fruhwirth Clemens.

You should have cc'ed Jari and Fruwirth, you'd probably get an amusing
flame fest.

Lee

