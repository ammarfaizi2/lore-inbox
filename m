Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaDWi>; Sat, 30 Dec 2000 22:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQLaDWT>; Sat, 30 Dec 2000 22:22:19 -0500
Received: from scaup.prod.itd.earthlink.net ([207.217.121.49]:47869 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129436AbQLaDWN>; Sat, 30 Dec 2000 22:22:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Re: strange behaviour with test13-pre6
Date: Sat, 30 Dec 2000 21:54:50 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <200012310240.DAA10504@john.epistle>
In-Reply-To: <200012310240.DAA10504@john.epistle>
MIME-Version: 1.0
Message-Id: <00123021545002.06254@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 December 2000 09:40 pm, mkloppstech@freenet.de wrote:
| With test13-pre6 I suddenly found that I could not change the
| console. When I wanted to enter a command letters were changed:
| greek \mu appeared for m,
| tilde n for e.
|
| After a few seconds the system returned to normal behaviour.
| No messages can be found in the logfiles.

similar behavior at boot, at least since test11, to wit: at boot: 
prompt, hitting tab causes what seems to be several pages of 
scrolling with the odd character here and there, in place of a list 
of available boot options. after several seconds, boot: prompt 
reappears as usual, and one may, if one has remembered their names, 
type in any of the possibilities, and boot that choice.
-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
