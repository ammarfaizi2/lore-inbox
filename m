Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTJYVrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTJYVrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:47:09 -0400
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:62516 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S262921AbTJYVrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:47:07 -0400
Message-ID: <3F9AEF53.1060108@planet.nl>
Date: Sat, 25 Oct 2003 23:46:59 +0200
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DI-30 system lockup in 2.6.0-test 1 thru 9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've filed a bug on the non working of the onstream DI-30 tape backup. 
Is there any chance of this getting fixed before 2.6.0. See also this 
bug report.

 http://bugzilla.kernel.org/show_bug.cgi?id=967

When using the tape drive the system violently locks up and only a 
reboot seems to work. This looks to me as a bug that would need some 
fixing or a marker that the driver is broken at this point in time

