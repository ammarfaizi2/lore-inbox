Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTABOQV>; Thu, 2 Jan 2003 09:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTABOQV>; Thu, 2 Jan 2003 09:16:21 -0500
Received: from mail.fibrespeed.net ([216.168.105.35]:41480 "HELO
	mail.fibrespeed.net") by vger.kernel.org with SMTP
	id <S261624AbTABOQU>; Thu, 2 Jan 2003 09:16:20 -0500
Date: Thu, 2 Jan 2003 10:24:38 -0500
From: "Michael T. Babcock" <mbabcock@fibrespeed.net>
To: linux-kernel@vger.kernel.org
Subject: Unknown error (please help direct it)
Message-ID: <20030102152438.GB12769@godzilla.fibrespeed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this in my logs from yesterday, with no clear indication as to
what subsystem it relates to.  Please help me direct this to the appropriate
persons (and CC me, if possible, in any replies).  There are no kernel messages
for several minutes before or after these lines.

13:50:28 vpn kernel:   Flags; bus-master 1, dirty 2677573(5) current 2677
13:50:28 vpn kernel:   Transmit list 00000000 vs. c57ad340.
13:50:28 vpn kernel:   0: @c57ad200  length 800005ea status 000105ea
13:50:28 vpn kernel:   1: @c57ad240  length 800003b2 status 000103b2
13:50:28 vpn kernel:   2: @c57ad280  length 800005ea status 000105ea
13:50:28 vpn kernel:   3: @c57ad2c0  length 800005ea status 000105ea
13:50:28 vpn kernel:   4: @c57ad300  length 800005ea status 800105ea
13:50:28 vpn kernel:   5: @c57ad340  length 800003b2 status 000103b2
13:50:28 vpn kernel:   6: @c57ad380  length 800005ea status 000105ea
13:50:28 vpn kernel:   7: @c57ad3c0  length 800005ea status 000105ea
13:50:28 vpn kernel:   8: @c57ad400  length 800005ea status 000105ea
13:50:28 vpn kernel:   9: @c57ad440  length 800005ea status 000105ea
13:50:28 vpn kernel:   10: @c57ad480  length 800005ea status 000105ea
13:50:28 vpn kernel:   11: @c57ad4c0  length 800003b2 status 000103b2
13:50:28 vpn kernel:   12: @c57ad500  length 800005ea status 000105ea
13:50:28 vpn kernel:   13: @c57ad540  length 800005ea status 000105ea
13:50:28 vpn kernel:   14: @c57ad580  length 800005ea status 000105ea
13:50:28 vpn kernel:   15: @c57ad5c0  length 800005ea status 000105ea
-- 
Michael T. Babcock
CTO, FibreSpeed Ltd.     (Hosting, Security, Consultation, Database, etc)
http://www.fibrespeed.net/~mbabcock/
