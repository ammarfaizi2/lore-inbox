Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTJANtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTJANtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:49:15 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:31502 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262153AbTJANs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:48:59 -0400
Subject: Re: 2.6.0-test5 - stuck keys on iBook
From: Brice Figureau <brice@tincell.com>
To: linuxppc-dev@lists.linuxppc.org
Cc: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030930143149.4930ec9c.cliffw@osdl.org>
References: <20030930143149.4930ec9c.cliffw@osdl.org>
Content-Type: text/plain
Message-Id: <1065016088.3283.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 01 Oct 2003 15:48:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 23:31, cliff white wrote:
> Kernel version: latest from ppc.bkbits.net/linuxppc-2.5
> 
> Symptom: keyboard diarrhea - single keypress == 3-7 characters.

I can confirm this problem on my ibook r2.2 with vanilla kernel.org 2.6.0-test6.
No problem with the latest test5 I tried.

Brice

