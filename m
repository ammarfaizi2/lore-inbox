Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbVCJULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbVCJULn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbVCJUF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:05:58 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:63584 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263097AbVCJUDA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:03:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=O4k7AJdSRXCpZZ2YkugYfKwC63dWr6+YTGOxvO8frcdOBnpoH28z9FwJZqMh6lslnwk7ZR1g2yGBI2eeqRYtPz9HmeIbIuHGkKdPMfsb1u8heAvWkAL5l5dUKUCYy2deT0zHoQgp9uyMzAaVuTHGDzC58vLzYNvIF5cRU1zcLZU=
Date: Thu, 10 Mar 2005 21:03:02 +0100
From: Diego Calleja <diegocg@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
Message-Id: <20050310210302.12938479.diegocg@gmail.com>
In-Reply-To: <423082BF.6060007@comcast.net>
References: <423075B7.5080004@comcast.net>
	<423082BF.6060007@comcast.net>
X-Mailer: Sylpheed version 1.9.5+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 10 Mar 2005 12:24:15 -0500,
John Richard Moser <nigelenki@comcast.net> escribió:

[...]
>  - Smaller kernel tree
[...]
>  - Better focused development
[...]
>  - Faster rebuilding for developers

It can be done without UDI.


> - UDI supplies SMP safety

Well designed drivers don't have SMP issues either...

