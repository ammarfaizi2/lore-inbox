Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRB1A1L>; Tue, 27 Feb 2001 19:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130016AbRB1A1C>; Tue, 27 Feb 2001 19:27:02 -0500
Received: from raven.toyota.com ([63.87.74.200]:38667 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S130008AbRB1A0l>;
	Tue, 27 Feb 2001 19:26:41 -0500
Message-ID: <3A9C45BE.B17DEEA6@toyota.com>
Date: Tue, 27 Feb 2001 16:26:38 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Manfred H. Winter" <mahowi@gmx.net>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.2-ac5] X (4.0.1) crashes
In-Reply-To: <20010227150830.A739@marvin.mahowi.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manfred H. Winter" wrote:

> I'm going back to vanilla 2.4.2 for now. Is there another way to get
> loop to work?

Working fine here:

2.4.2 + Axboe's loop patch + Morton's low latency patch

jjs

