Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143674AbRAHNRA>; Mon, 8 Jan 2001 08:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143637AbRAHNQu>; Mon, 8 Jan 2001 08:16:50 -0500
Received: from Cantor.suse.de ([194.112.123.193]:48135 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S143703AbRAHNQh>;
	Mon, 8 Jan 2001 08:16:37 -0500
Mail-Copies-To: never
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suggest: diff-2.4.0-test12_to_2.4.0
In-Reply-To: <3A59C971.11051.151608E@localhost>
From: Andreas Jaeger <aj@suse.de>
Date: 08 Jan 2001 14:16:31 +0100
In-Reply-To: <3A59C971.11051.151608E@localhost>
Message-ID: <hohf3a18wg.fsf@gee.suse.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ulrich Windl writes:

 > I thought I'd find a diff between 2.4.0test12 (last test release) to 
 > the final 2.4.0 release, but did not. Wouldn't it be (have been) a good 
 > idea?

Apply:
patch-2.4.0-prerelease.bz2 and then prerelease-to-final.bz2 to test12
and you get 2.4.0 final.

You'll find both in ftp.*.kernel.org/...kernel/v2.4/test-kernels/

Andreas

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
