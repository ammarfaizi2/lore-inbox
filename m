Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTG2AGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 20:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271069AbTG2AGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 20:06:14 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:40856 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270272AbTG2AGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 20:06:13 -0400
Message-ID: <3F25B926.10901@rackable.com>
Date: Mon, 28 Jul 2003 17:00:38 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ronald Jerome <imun1ty@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RPM QUESTION
References: <20030728233344.43084.qmail@web13304.mail.yahoo.com>
In-Reply-To: <20030728233344.43084.qmail@web13304.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jul 2003 00:06:12.0507 (UTC) FILETIME=[38890EB0:01C35565]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Jerome wrote:

>Will RPM be working anytime soon in kernel-2.6.0-test
>series?
>

  Define working?  Are you running redhat 9.0?  If so that's redhat's 
fault.  Try  "LD_ASSUME_KERNEL=2.2.5 <whatever the rpm command is>"

>
>In my opinion this question needs to be addressed
>since two main distro's use RPM and for those who are
>spending their time testing I would think its worth an answer.
>
  Redhat seems to be able to create rpms.
http://people.redhat.com/arjanv/2.5/

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


