Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVC3SJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVC3SJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVC3SJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:09:34 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:59264 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262369AbVC3SJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:09:29 -0500
Date: Wed, 30 Mar 2005 20:10:07 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
Message-ID: <20050330181007.GA17835@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050330162114.GA1028@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050330162114.GA1028@DervishD>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all and sorry for self-answering:
 * DervishD <lkml@dervishd.net> dixit:

> 'linux-libc-headers', but I've noticed that it provides headers for
> 'scsi/' subdir, and glibc *does that too*. Should I use the scsi
> headers from llh? Should I instead compiled my new glibc without that
> headers and let it install them as needed? Should I NOT use any linux
> header for building my new glibc (2.3.4 BTW)?

    Yes, I know, this is in the llh FAQ, but the answer starts with
'Not too sure on this one', that's the reason I'm asking here...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
