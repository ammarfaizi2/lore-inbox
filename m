Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbTHRMru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271703AbTHRMru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:47:50 -0400
Received: from [62.13.18.67] ([62.13.18.67]:2497 "EHLO mail.kontorshotellet.nu")
	by vger.kernel.org with ESMTP id S270082AbTHRMrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:47:49 -0400
Message-ID: <3F40CAF1.4000801@lanil.mine.nu>
Date: Mon, 18 Aug 2003 14:47:45 +0200
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030814 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Loschwitz <madkiss@madkiss.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI related problems on an Acer TravelMate 800LCi
References: <20030818112717.GA1688@minerva.local.lan>
In-Reply-To: <20030818112717.GA1688@minerva.local.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Loschwitz wrote:

>Hi folks,
>
>I am encoutering ACPI related problems with 2.6.0-test3 and my Acer TravelMate
>800 LCi. Everytime I try to send it to suspend mode ('echo 3 > /proc/acpi/sleep'), 
>the following lines appears in syslog and the box does not suspend at all:
>
>[snip OOPS]
>
I can verify this, I will try to capture my OOPS somehow as my machine 
locks up hard before I can do anything.
For you info, the 800 LCi is a centrino based computer.

Regards

--
Christian Axelsson
smiler@lanil.mine.nu


