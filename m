Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318135AbSHDQub>; Sun, 4 Aug 2002 12:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHDQua>; Sun, 4 Aug 2002 12:50:30 -0400
Received: from adsl-66-141-54-235.dsl.austtx.swbell.net ([66.141.54.235]:45710
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S318135AbSHDQua>; Sun, 4 Aug 2002 12:50:30 -0400
Subject: ps is slow with large files_max
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1028479926.27839.3.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 04 Aug 2002 11:52:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with 8gb ram, and 35000 for files_max setting, with ~23000
allocated, ps -ef or ps aux, top, etc, are very very slow to display. Is
there something I can do to speed this up? No other negative problems
have been seen. 

System is Dell 6650 8gb Ram quad P4 Xeon 1.6ghz. TIA

-- Austin Gonyou
"Co-Founder Armed Linux"
