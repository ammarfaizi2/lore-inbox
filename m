Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263411AbREXI3d>; Thu, 24 May 2001 04:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263412AbREXI3X>; Thu, 24 May 2001 04:29:23 -0400
Received: from earth.msynet.gr.jp ([210.154.76.130]:7714 "EHLO
	earth.msynet.gr.jp") by vger.kernel.org with ESMTP
	id <S263411AbREXI3H>; Thu, 24 May 2001 04:29:07 -0400
Message-Id: <200105240829.AA00181@basecamp.msynet.gr.jp>
From: Seiichi Nakashima <nakasei@msynet.gr.jp>
Date: Thu, 24 May 2001 17:29:03 +0900
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rsrc_mgr.c - null ptr fix for 2.4.4
In-Reply-To: <200105240734.f4O7YB404249@smtp1.Stanford.EDU>
In-Reply-To: <200105240734.f4O7YB404249@smtp1.Stanford.EDU>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.11
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now, I found that many null ptr fix add in linux-2.4.4.
Do other kernels ( 2.2.x or 2.0.x ) affect them. 

Praveen Srinivasan wrote
>Hi,
>This fixes an unchecked ptr bug in the resource manager code for the PCMCIA 
>driver (rsrc_mgr.c).
>
>Praveen Srinivasan and Frederick Akalin
>

------------------------------
 Name   : Seiichi Nakashima
 E-Mail : nakasei@msynet.gr.jp
------------------------------
