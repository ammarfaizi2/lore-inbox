Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313778AbSDHWID>; Mon, 8 Apr 2002 18:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313781AbSDHWIC>; Mon, 8 Apr 2002 18:08:02 -0400
Received: from mnh-1-20.mv.com ([207.22.10.52]:15114 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S313778AbSDHWIB>;
	Mon, 8 Apr 2002 18:08:01 -0400
Message-Id: <200204082309.SAA04661@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.56-2.4.18-15 
In-Reply-To: Your message of "08 Apr 2002 16:02:48 -0400."
             <1018296173.913.162.camel@phantasy> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 18:09:53 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rml@tech9.net said:
> If these drivers truly are sufficient candidates for feeding /dev/
> random, perhaps you could pull these bits and submit them to Linus and
> Marcelo? 

They're UML drivers, so they're not useful anywhere except in UML.

				Jeff

