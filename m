Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCLQVB>; Mon, 12 Mar 2001 11:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRCLQUx>; Mon, 12 Mar 2001 11:20:53 -0500
Received: from www.wen-online.de ([212.223.88.39]:19213 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129245AbRCLQUm>;
	Mon, 12 Mar 2001 11:20:42 -0500
Date: Mon, 12 Mar 2001 17:20:12 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Feedback for fastselect and one-copy-pipe
In-Reply-To: <20010312151548.B878@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33.0103121710030.927-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Ingo Oeser wrote:

> They seem to work for me, but there seems to be a memleak in
> 2.4.x (x: 0-2), which I'm chasing down.

I just happen to have a 2.4.2 IKD patch sitting here, and therein
sits Ingo's memory leak detector... poor thing is bored to tears 8)

	-Mike

