Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289174AbSAMNBP>; Sun, 13 Jan 2002 08:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289175AbSAMNA5>; Sun, 13 Jan 2002 08:00:57 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:1590 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S289174AbSAMNAn>; Sun, 13 Jan 2002 08:00:43 -0500
Message-ID: <3C41849D.72ECBC05@kolumbus.fi>
Date: Sun, 13 Jan 2002 14:59:09 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-audio-dev@music.columbia.edu
CC: linux-kernel@vger.kernel.org
Subject: 2.4.x, patches and latencies
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Finally I got the my system back to 2.4.12-ac3-ll level latencies and
smoothness and it's in fact performing significantly better.

See http://www.pp.song.fi/~visitor/latencytest5/3x256.html for latency
results. (Sound driver is OSS 3.9.5f)

Patches used against 2.4.17 are:

 - Andre's IDE patch
 - Rik's rmap-11b
 - Ingo's O(1)-H6
 - Andrew's full lowlatency
 - My additions to lowlatency

Now I'm quite happy with this!


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

