Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSASMpp>; Sat, 19 Jan 2002 07:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287237AbSASMpf>; Sat, 19 Jan 2002 07:45:35 -0500
Received: from ua18d4hel.dial.kolumbus.fi ([62.248.131.18]:45426 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287200AbSASMp0>; Sat, 19 Jan 2002 07:45:26 -0500
Message-ID: <3C496A67.5237873F@kolumbus.fi>
Date: Sat, 19 Jan 2002 14:45:27 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-audio-dev@music.columbia.edu
CC: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, patches and latencies
In-Reply-To: <3C41849D.72ECBC05@kolumbus.fi> <3C41AC11.4060806@drugphish.ch> <3C41BFF1.6FF714A1@kolumbus.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> 
> Roberto Nibali wrote:
> >
> > Could you please post this as a unified diff against 2.4.17 on your
> > webpage, so others can test it too?

I made a web page for my kernel patch combinations. Aimed primarily for low
latency use.

http://www.pp.song.fi/~visitor/linux/

Latest 2.4.17-jl11 contains:

 - Andre's ide driver update
 - Lionel's SiS ide driver update
 - ALi ide fix
 - Small AGP fix
 - Updated VIA KT133/KT266 fix
 - Rik's rmap-11c
 - Ingo's sched-O1-J2

-jl11-mini also contains:

 - mini-ll patch

-jl11-ll also contains:

 - full lowlatency patch
 - my DRM lowlatency patch


Best regards,

	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

