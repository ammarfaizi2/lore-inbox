Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSFHLWo>; Sat, 8 Jun 2002 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSFHLWn>; Sat, 8 Jun 2002 07:22:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6788 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317401AbSFHLWm>;
	Sat, 8 Jun 2002 07:22:42 -0400
Date: Sat, 8 Jun 2002 16:51:47 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: question: i/o port 0x61 on x86 archs
Message-ID: <20020608165147.A16911@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question regdg do_nmi routine in x86; what does location 0x61 
from inb(0x61) do? Is it something very well known in intel archs? 

Kiran
