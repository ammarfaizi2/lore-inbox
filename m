Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbRE2PbX>; Tue, 29 May 2001 11:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262423AbRE2PbO>; Tue, 29 May 2001 11:31:14 -0400
Received: from mail3.home.nl ([213.51.129.227]:12732 "EHLO mail3.home.nl")
	by vger.kernel.org with ESMTP id <S262312AbRE2PbB>;
	Tue, 29 May 2001 11:31:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: elko <elko@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
Date: Tue, 29 May 2001 17:37:17 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E154fWT-0004BO-00@the-village.bc.nu>
In-Reply-To: <E154fWT-0004BO-00@the-village.bc.nu>
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <01052917371700.32333@ElkOS>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 May 2001 11:10, Alan Cox wrote:
> > It's not a bug.  It's a feature.  It only breaks systems that are run w=
> > ith "too
> > little" swap, and the only difference from 2.2 till now is, that the de=
> > finition
> > of "too little" changed.
>
> its a giant bug. Or do you want to add 128Gb of unused swap to a full
> kitted out Xeon box - or 512Gb to a big athlon ???

this bug is biting me too and I do NOT like it !

if it's a *giant* bug, then why is LK-2.4 called a *stable* kernel ??

-- 
Elko Holl
