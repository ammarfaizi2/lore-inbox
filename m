Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVAGSM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVAGSM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVAGSLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:11:49 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:2210 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261519AbVAGSID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:08:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=pyugVFk640x7wTpC2ygAYF+isu4V6BRRHPvjjqt5QyDxBfjZhfSHwMLFFyq6DBnQi3DmOgoQ9X2j9zKR4UAFI76m5uHxfssvXBLNCfi0peTi8Mb1HXCFWNyXmfczyChet5LaiW2dd84K3GxyGBfxzke3iWh0TKr1lanahqONTE8=
Message-ID: <7bb8b8de05010710085ea81da9@mail.gmail.com>
Date: Fri, 7 Jan 2005 10:08:02 -0800
From: Shaw <shawvrana@gmail.com>
Reply-To: shawvrana@acm.org
To: Pavel Machek <pavel@ucw.cz>, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: Screwy clock after apm suspend
Cc: linux-kernel@vger.kernel.org, plazmcman@softhome.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Just thought I'd add that I too am seeing a big time drift on my
Thinkpad (T30) without ACPI during an APM suspend w/ 2.6.10.  If I can
help by testing patches, or providing any additional information,
please let me know.

Thanks,
Shaw
