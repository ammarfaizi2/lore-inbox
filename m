Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTHGRno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270234AbTHGRmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:42:07 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:11662 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP id S270040AbTHGRlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:41:19 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Newsgroups: local.ml.linux.kernel
From: dalgoda@ix.netcom.com (Mike Castle)
Subject: Re: IDE DMA problem with 2.6.0-test1
References: <200308061551.01571.sandersn@btinternet.com> <Pine.SOL.4.30.0308061750260.22000-100000@mion.elka.pw.edu.pl>
Organization: House of Linux
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Path: not-for-mail
Originator: nexus@thune.mrc.org (Mike Castle)
Date: Thu, 07 Aug 2003 10:41:16 -0700
Message-ID: <sifa01x0g7.ln2@thune.mrc-home.org>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SOL.4.30.0308061750260.22000-100000@mion.elka.pw.edu.pl>,
Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
>You can also install smartmontools (http://smartmontools.sf.net/)
>and check your drives (if they support SMART of course).


Point of interest:  I just had a Maxtor drive go bad on me recently.  Their
diag tools caught it, as did my ear (made a nice clunking noise :-).  But
SMART didn't report a thing, and I looked hard too.  :-/

mrc

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
