Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267003AbUBEWoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267014AbUBEWoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:44:06 -0500
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:30936 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267003AbUBEWoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:44:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ryanr@uchicago.edu
Subject: Re: 2.6.2-ck1
Date: Fri, 6 Feb 2004 09:43:40 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200402052109.24122.kernel@kolivas.org>
In-Reply-To: <200402052109.24122.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402060943.40973.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan

>I get "bad: scheduling while atomic" on boot, before init starts.  Full 
>dmesg follows.  It appears to follow the discovery of my "initrd," which is 
>really just a bootsplash image (I don't use initrd for anything else).

Do you patch in anything else? Can you send me your .config (off the list will 
be fine for this).

Con

P.S. It is convention on the mailing list to "reply to all" when posting a 
response on lkml.
