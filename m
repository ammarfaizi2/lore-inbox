Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbUJZGNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbUJZGNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUJZGNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:13:50 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:55744 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262062AbUJZGMb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:12:31 -0400
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 26 Oct 2004 06:12:29 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 26 Oct 2004 01:12:29 -0500
Subject: Re: power/disk.c: small fixups
X-Originating-Ip: 172.192.187.181
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20041026061229.E49AB4BDA9@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(re: "it's" and similar non-code documentation issues, plus
a tangent from a completely different topic)

Among the best references ever on "The King's English"
(traditional phrase informally meaning "correct English
usage"):

_The Elements of Style_, Strunk and White:

  <http://www.bartleby.com/141/>

The above work is not an encyclopedic reference on
English usage (not complete), but nonetheless:

  "The pronominal possessives hers, its, theirs, yours,
   and oneself have no apostrophe."

So, if "it's" is not a possessive, then it's a
contraction, where the ' represents one or
more omitted letters. (No comment on the "it has"
variant, which I cannot remember ever seeing
in practice but can think of no reason for ruling
out as definitively incorrect usage.)

----

Touching on a tangent from an earlier topic
this week, what about a small, very sensitive emi
collector that plugs into a ps/2 mouse port,
serial port or usb port on a headless, keyboardless,
interactive-user-less server? Something sending
environmentally random data at a rate designed
to accumulate abundant real entropy without hosing
server performance on headless boxes?

(One wants "background noise of the universe"
for a usable input source, at a data rate
high enough to get rid of that nagging anxiety
about whether one always has enough entropy for
ipsec, etc, when no one is using the keyboard or
mouse, there may or may not be any disks, network
data flows tend to stay at fairly consistent rates
due to rate-limiting, etc.)

Regards,

Clayton Weaver
<mailto: cgweav@email.com>
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

