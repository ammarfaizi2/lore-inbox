Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312770AbSCZVwu>; Tue, 26 Mar 2002 16:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSCZVwk>; Tue, 26 Mar 2002 16:52:40 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:23003 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S312770AbSCZVw0>; Tue, 26 Mar 2002 16:52:26 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Newsgroups: local.ml.linux.kernel
From: dalgoda@ix.netcom.com (Mike Castle)
Subject: Re: version.h missing from 2.4.18?
In-Reply-To: <20020325.234400.03241011.davem@redhat.com> <PPENJLMFIMGBGDDHEPBBKEAPCMAA.ashokr2@attbi.com>
Organization: House of Linux
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Path: not-for-mail
Originator: nexus@thune.mrc.org (Mike Castle)
Date: Tue, 26 Mar 2002 13:52:09 -0800
Message-ID: <9iqq7a.rn1.ln@thune.mrc-home.org>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <PPENJLMFIMGBGDDHEPBBKEAPCMAA.ashokr2@attbi.com>,
Ashok Raj <ashokr2@attbi.com> wrote:
>Iam not sure if iam the only one doing this, could this be added to the
>kernel source tree?

Use the EXTRAVERSIONS setting in the top level makefile.

mrc

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
