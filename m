Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289296AbSBDXhQ>; Mon, 4 Feb 2002 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289293AbSBDXg5>; Mon, 4 Feb 2002 18:36:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39608 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289291AbSBDXgr>;
	Mon, 4 Feb 2002 18:36:47 -0500
Date: Tue, 5 Feb 2002 02:34:33 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5F1A17.A0713D5@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202050233160.21339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Jussi Laako wrote:

> Thus receiving "CPU hog" process is losing blocks of data.

i understand, and we want to handle such cases perfectly as well.

How much of a CPU hog is your task? What does 'top' show while you are
using your app? (pasting top output here will show the situation.)

	Ingo

