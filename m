Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264007AbRFSIKl>; Tue, 19 Jun 2001 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264008AbRFSIKb>; Tue, 19 Jun 2001 04:10:31 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:57474
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S264007AbRFSIK0>; Tue, 19 Jun 2001 04:10:26 -0400
Date: Tue, 19 Jun 2001 01:12:14 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
In-Reply-To: <Pine.LNX.4.30.0106182320510.2168-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.33.0106190106220.26701-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Shawn Starr wrote:

> 1) It broke apparently with gcc 2.95.3 when patching from 2.4.6-pre2 ->
> 2.4.6pre3
>
> 2) I tried building it with gcc 3.00 and had same result.

hmm, how ironic, i just had 2.4.5ac15 lock up when untarring gcc 3.0 on a
reiserfs partition (/)

This after only using ac15 for a few hours... I've never seen anything
like that with ac13, which I've used for days.


Justin

