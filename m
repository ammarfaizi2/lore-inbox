Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWEDPCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWEDPCa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWEDPCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:02:30 -0400
Received: from mailtir.platform.com ([192.219.104.248]:19348 "EHLO
	mailtir.platform.com") by vger.kernel.org with ESMTP
	id S1751494AbWEDPC3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:02:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [2.6.17-rc3][sky2] Network stalls/drops completely
Date: Thu, 4 May 2006 11:02:02 -0400
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DE3F84FB@catoexm05.noam.corp.platform.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.17-rc3][sky2] Network stalls/drops completely
Thread-Index: AcZvk9i3+S2V8lJZRHaoCN8QNcBJ0gAACoYw
From: "Shawn Starr" <sstarr@platform.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(plain text this time)

Hi Stephen, 
 
We just got some new boxes and they have a sky2 nic onboard. The card seems ok but over time I start to get network drops. Also, If I restart the network I deadlocked the kernel unfortunately I don't have a stack dump of the crash.
 
I see you've made some changes in -git perhaps I should try a git snapshot to see if the sky2 issues have been fixed?
 
Thanks, 
 
Shawn.
