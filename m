Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTB1HgI>; Fri, 28 Feb 2003 02:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTB1HgH>; Fri, 28 Feb 2003 02:36:07 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:22727 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267611AbTB1HgH>; Fri, 28 Feb 2003 02:36:07 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Date: Fri, 28 Feb 2003 08:46:01 +0100
User-Agent: KMail/1.5
Cc: dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030227025900.1205425a.akpm@digeo.com> <20030227160656.40ebeb93.akpm@digeo.com> <200302281128.06840.kernel@kolivas.org>
In-Reply-To: <200302281128.06840.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302280846.04002.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con, are you sure this is not the same for 2.5.63?
I left 2.5.63 running over night (doing nothing but run
KDE), and in the morning it was swapping heavily.
About 200MB was swapped out and this did not reduce
with usage.  According to top, 10% of memory was being
used by a Konsole with nothing in it (could be a memory
leak in Konsole).  After half an hour I gave up - it was
too unusable.  Maybe -mm1 just accentuates a problem
that is already there in 2.5.63.

Ciao,

Duncan.
