Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136919AbRA1OCF>; Sun, 28 Jan 2001 09:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137084AbRA1OBz>; Sun, 28 Jan 2001 09:01:55 -0500
Received: from james.kalifornia.com ([208.179.0.2]:46694 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136919AbRA1OBj>; Sun, 28 Jan 2001 09:01:39 -0500
Message-ID: <3A7426E1.728BB87D@kalifornia.com>
Date: Sun, 28 Jan 2001 06:04:17 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
CC: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.SOL.4.21.0101280852470.14226-100000@green.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:

> I'm sure we all know what the IETF is, and where ECN came from. I haven't
> seen anyone suggesting ignoring RST, either: DM just imagined that,
> AFAICS.
>
> The one point I would like to make, though, is that firewalls are NOT
> "brain-damaged" for blocking ECN: according to the RFCs governing
> firewalls, and the logic behind their design, blocking packets in an
> unknown format (i.e. with reserved bits set) is perfectly legitimate. Yes,
> those firewalls should be updated to allow ECN-enabled packets
> through. However, to break connectivity to such sites deliberately just
> because they are not supporting an *experimental* extension to the current
> protocols is rather silly.

Do keep in mind, we aren't breaking connectivity, they are.

-b


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
