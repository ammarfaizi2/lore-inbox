Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSLOUmn>; Sun, 15 Dec 2002 15:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSLOUmn>; Sun, 15 Dec 2002 15:42:43 -0500
Received: from conductor.synapse.net ([199.84.54.18]:28171 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S262492AbSLOUmm> convert rfc822-to-8bit; Sun, 15 Dec 2002 15:42:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
Date: Sun, 15 Dec 2002 15:49:37 -0500
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212151549.37661.marvin@synapse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

( that's a capital-aye in the hdparm line )

not even the Magic SysReq key will work.

also, don't

"cd /proc/ide/hde ; cat identify"

... same thing
drive-light comes on, but have to use the power-switch to get the machine 
back, ( lost stuff again, fuck )


proc says it's pdc202xx

Promise Ultra series driver Ver 1.20.0.7 2002-05-23
Adapter: Ultra100 on M/B

-- 
http://www.drawright.com/
 - "The New Drawing on the Right Side of the Brain" ( Betty Edwards, 
check "Theory", "Gallery", and "Exercises" )
http://www.ldonline.org/ld_indepth/iep/seven_habits.html
 - "The 7 Habits of Highly Effective People" ( this site is same 
principles as Covey's book )
http://www.eiconsortium.org/research/ei_theory_performance.htm
 - "Working With Emotional Intelligence" ( Goleman: this link is 
/revised/ theory, "Working. . . " is practical )
http://www.leadershipnow.com/leadershop/1978-5.html
 - Corps Business: The 30 /Management Principles/ of the U.S. Marines ( 
David Freedman )
