Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUJNXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUJNXRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJNXRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:17:25 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:63885 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267508AbUJNXPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:15:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Date: Thu, 14 Oct 2004 18:15:02 -0500
User-Agent: KMail/1.6.2
Cc: William Wolf <wwolf@vt.edu>, akpm@zip.com.au
References: <416EE7EB.4070209@vt.edu>
In-Reply-To: <416EE7EB.4070209@vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410141815.03110.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 October 2004 03:56 pm, William Wolf wrote:
> Hey, I just tried -rc4-mm1 on my amd64 laptop, and my keyboard fails to
> work, I don't even think it is being recognized. 

Could you try booting with i8042.noacpi and if it helps mailing me your
/proc/acpi/dsdt?

Thanks!

-- 
Dmitry
