Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSJPQc5>; Wed, 16 Oct 2002 12:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJPQc5>; Wed, 16 Oct 2002 12:32:57 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:53033 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id <S265174AbSJPQc4>; Wed, 16 Oct 2002 12:32:56 -0400
From: Simon Roscic <simon.roscic@chello.at>
To: GrandMasterLee <masterlee@digitalroadkill.net>
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Date: Wed, 16 Oct 2002 18:38:39 +0200
User-Agent: KMail/1.4.7
References: <200210152120.13666.simon.roscic@chello.at> <1034744519.29307.26.camel@localhost>
In-Reply-To: <1034744519.29307.26.camel@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210161838.39824.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2002 07:02, GrandMasterLee <masterlee@digitalroadkill.net> wrote:
> Do you use LVM, EVMS, MD, other, or none?
>

none.
it's a XFS filesystem with the folowing mount options:
rw,noatime,logbufs=8,logbsize=32768

(this apply's to all 3 machines)

simon.
(please CC me, i'm not subscribed to lkml)

