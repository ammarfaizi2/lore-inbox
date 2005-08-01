Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVHACQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVHACQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 22:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVHACQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 22:16:26 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:14833 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261984AbVHACQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 22:16:25 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space (updated)
References: <20050728145353.GL11644@mellanox.co.il>
	<Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 01 Aug 2005 11:15:55 +0900
In-Reply-To: <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Fri, 29 Jul 2005 09:40:14 +0200 (MEST)")
Message-Id: <buo8xzmcsh0.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>>3i. if/else/do/while/for/switch
>>	space between if/else/do/while and following/preceeding
>>	statements/expressions, if any
>
> Why this? if(a) {} is not any worse than if (a).

Well it's harder to read (because it makes control constructs look more
like function calls).  And a bit uglier.

But anyway, coding styles are rarely about "worse" versus "better",
they're about keeping things consistent so that it's easier to read
code.

-Miles
-- 
Any man who is a triangle, has thee right, when in Cartesian Space, to
have angles, which when summed, come to know more, nor no less, than
nine score degrees, should he so wish.  [TEMPLE OV THEE LEMUR]
