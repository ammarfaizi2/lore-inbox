Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270067AbRHMKaD>; Mon, 13 Aug 2001 06:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270069AbRHMK3x>; Mon, 13 Aug 2001 06:29:53 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:8894
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S270067AbRHMK3k>; Mon, 13 Aug 2001 06:29:40 -0400
Date: Mon, 13 Aug 2001 03:29:53 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Are we going too fast?
In-Reply-To: <20010813105059.B1071-100000@gerard>
Message-ID: <Pine.LNX.4.33.0108130327460.27721-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Gérard Roudier wrote:

> You may want to elaborate on the ncr53c8xx problems (I maintain this
> driver). More generally, you must not ignore the thousands of bugs in the
> hardware you are using, but software developpers haven't access to all
> errata descriptions since hardware vendors donnot like to make this
> information freely available.

I've got a quick unrelated question.

Why not change the name (or at least the description) of sym53c8xx to
include the 53c1010 chips, which this driver seems to work on (and on a
SMP box, no less)?


justin

