Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRCYPgT>; Sun, 25 Mar 2001 10:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRCYPgJ>; Sun, 25 Mar 2001 10:36:09 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:14348 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S132039AbRCYPgB>; Sun, 25 Mar 2001 10:36:01 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: Larger dev_t
Date: 25 Mar 2001 17:35:01 +0200
Organization: Cistron Internet Services
Message-ID: <99l375$rn5$1@picard.cistron.nl>
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>,
 <Andries.Brouwer@cwi.nl> wrote:
>a large name space allows one to omit checking what part can be
>reused - reuse is unnecessary.

You are just delaying the problem then, at some point your uptime will
be large enough that you have run through all 64bit pids for example.

Wichert.


-- 
   ________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

