Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSBOVOE>; Fri, 15 Feb 2002 16:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSBOVNw>; Fri, 15 Feb 2002 16:13:52 -0500
Received: from ns.suse.de ([213.95.15.193]:62982 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292131AbSBOVNn> convert rfc822-to-8bit;
	Fri, 15 Feb 2002 16:13:43 -0500
To: Olivier Kaloudoff <kalou@kalou.net>
Cc: linux-kernel@vger.kernel.org, qa@mandrakesoft.com
Subject: Re: 2.4.17: LOOP_SET_FS: Invalid argument
In-Reply-To: <Pine.LNX.4.43.0202151458150.2090-100000@clients.nfrance.com>
X-Yow: Did an Italian CRANE OPERATOR just experience uninhibited sensations
 in a MALIBU HOT TUB?
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 15 Feb 2002 22:13:39 +0100
In-Reply-To: <Pine.LNX.4.43.0202151458150.2090-100000@clients.nfrance.com> (Olivier
 Kaloudoff's message of "Fri, 15 Feb 2002 15:05:57 +0100 (CET)")
Message-ID: <jeheoibg8s.fsf@suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Kaloudoff <kalou@kalou.net> writes:

|> Hi gurus,
|> 
|> 
|> 	I'm simply trying to mount a filesystem
|> located in a file, and get in trouble with this
|> message I don't understand...

Perhaps /tmp is mounted as tmpfs?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
