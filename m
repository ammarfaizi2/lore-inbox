Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272780AbTHPGys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272788AbTHPGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 02:54:48 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:50891
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272780AbTHPGyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 02:54:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O16int for interactivity
Date: Sat, 16 Aug 2003 17:01:01 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
References: <200308160149.29834.kernel@kolivas.org>
In-Reply-To: <200308160149.29834.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161701.01689.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 01:49, Con Kolivas wrote:
> Tasks cannot preempt their own waker.

Looks like I can do this with a lot less code. Will post an update to this 
which doesn't significantly change functionality but culls a lot of code.
Thanks Mike.

Con

