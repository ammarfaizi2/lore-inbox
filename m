Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTLUMsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 07:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTLUMsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 07:48:13 -0500
Received: from crisium.vnl.com ([194.46.8.33]:53266 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S262925AbTLUMsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 07:48:12 -0500
Date: Sun, 21 Dec 2003 12:48:12 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there still at 2TB limit?
Message-ID: <20031221124812.GE5126@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
References: <20031221010112.GX25351@vnl.com> <20031221101406.GA3211@localhost> <20031221121158.GA5126@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221121158.GA5126@vnl.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 12:11:58PM +0000, Dale Amon wrote:
> Thanks. I notice the notes there are quite old. Are 
> there libraries available now that work with LFS?

Actually I've got the answer. glibc 2.1.3 has full api;
glibc 2.2 has full support; I'm currently using glibc
2.3.2ds1 so if I toggle on that LFS option, it should
all just work merrily with many terries of bytes.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------
