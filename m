Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315960AbSEGUDe>; Tue, 7 May 2002 16:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315961AbSEGUDd>; Tue, 7 May 2002 16:03:33 -0400
Received: from outbound.ea.com ([12.35.91.3]:60110 "EHLO outbound.ea.com")
	by vger.kernel.org with ESMTP id <S315960AbSEGUDc>;
	Tue, 7 May 2002 16:03:32 -0400
Subject: Has anyone integrated the e1000 driver into the 2.4.x kernel
From: Thomas Schenk <tschenk@origin.ea.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 07 May 2002 15:04:08 -0500
Message-Id: <1020801852.26725.23.camel@bagend.origin.ea.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working a project where I need to be able to compile the Intel
e1000 driver into a monolithic kernel, but the readme says that you can
only use the driver as a module.  Is there some technical reason why
this driver cannot be compiled into the kernel instead of being used as
a module?

Tom S.

-- 
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
| Tom Schenk      | A positive attitude may not solve all your    |
| Online Ops      | problems, but it will annoy enough people to  |
| tschenk@ea.com  | make it worth the effort. -- Herm Albright    |
+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

