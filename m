Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135249AbRDLSW4>; Thu, 12 Apr 2001 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135250AbRDLSWq>; Thu, 12 Apr 2001 14:22:46 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39234 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S135249AbRDLSWi>; Thu, 12 Apr 2001 14:22:38 -0400
Message-ID: <002101c0c37d$a37a3f40$f0149aa3@engr.sgi.com>
From: "John Hawkes" <hawkes@engr.sgi.com>
To: <smaneesh@in.ibm.com>, "Anton Blanchard" <anton@samba.org>
Cc: <tridge@samba.org>, "lkml" <linux-kernel@vger.kernel.org>,
        "lse tech" <lse-tech@lists.sourceforge.net>
In-Reply-To: <20010409201311.D9013@in.ibm.com> <20010411182929.A16665@va.samba.org> <20010412211354.A25905@in.ibm.com>
Subject: Re: [Lse-tech] Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
Date: Thu, 12 Apr 2001 11:23:14 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maneesh Soni" <smaneesh@in.ibm.com>
...
> Though I intend to do some
> profiling to look into this but it will be helpfull if you can tell me
if there
> is some known thing regarding this.
...

Another useful tool is Lockmeter, which gives you visibility to what's
happening with spinlock_t and rwlock_t usage.
http://oss.sgi.com/projects/lockmeter

John Hawkes
hawkes@engr.sgi.com


