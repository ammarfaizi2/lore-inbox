Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292328AbSBPJSv>; Sat, 16 Feb 2002 04:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSBPJSb>; Sat, 16 Feb 2002 04:18:31 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:49657 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292328AbSBPJSX>; Sat, 16 Feb 2002 04:18:23 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C6E1F90.40404@dplanet.ch> 
In-Reply-To: <3C6E1F90.40404@dplanet.ch> 
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild [which is not only ...2] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Feb 2002 09:18:17 +0000
Message-ID: <22527.1013851097@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cate@dplanet.ch said:
>  I have some comment/explications about the thread about kbuild.

The thread isn't about kbuild. It's about <omitted>. Please do not confuse
the two or even mention them in the same mail. It only serves to promote the 
confusion.

kbuild is far more obviously the right thing to do. The main objection to it
last time I saw a discussion was that it has a performance problem in
certain cases -- which I believe Keith is working on. 

It's not clear to me that you asking for it to be reconsidered before that's
complete is useful.

--
dwmw2


