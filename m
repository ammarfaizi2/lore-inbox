Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSKKUUt>; Mon, 11 Nov 2002 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSKKUUs>; Mon, 11 Nov 2002 15:20:48 -0500
Received: from trained-monkey.org ([209.217.122.11]:49414 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S261238AbSKKUUs>; Mon, 11 Nov 2002 15:20:48 -0500
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-acenic@SunSITE.dk
Subject: Re: acenic problems on 2.5.47
References: <200211111416.56167.habanero@us.ibm.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 11 Nov 2002 15:26:32 -0500
In-Reply-To: Andrew Theurer's message of "Mon, 11 Nov 2002 14:16:56 -0600"
Message-ID: <m3lm3zettz.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Theurer <habanero@us.ibm.com> writes:

Andrew> I seem to be having a driver issue with acenic Gb adapters on
Andrew> 2.5.47.  Out of four adapters, usually one, but sometimes two
Andrew> of the four adapters are initialized upon 'insmod acenic':

Hmmm what kinda box is this on? The old problem was related to
hardware doing posted writes (like ia64 and PPC64 boxes), however I
believe the changes for that went into the main tree.

Cheers,
Jes

