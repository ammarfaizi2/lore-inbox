Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUJVVWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUJVVWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJVVE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:04:57 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:2438 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267921AbUJVVBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:01:39 -0400
Message-ID: <4179752F.90806@nortelnetworks.com>
Date: Fri, 22 Oct 2004 15:01:35 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: slew rate of time_interpolator_update()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to figure out the max slew rate of time_interpolator_update().  Does 
anyone know off the top of their heads?

Chris
