Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbSKPB5c>; Fri, 15 Nov 2002 20:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbSKPB5c>; Fri, 15 Nov 2002 20:57:32 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:10258 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267198AbSKPB5b>;
	Fri, 15 Nov 2002 20:57:31 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-rc2 
In-reply-to: Your message of "Fri, 15 Nov 2002 13:10:07 -0200."
             <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Nov 2002 13:04:02 +1100
Message-ID: <7883.1037412242@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002 13:10:07 -0200 (BRST), 
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>So here goes -rc2, fixing the lcall DoS.

No obvious changes that affect kdb, so unless somebody reports
problems, use kdb-v2.5-2.4.20-rc1 with -rc2.

