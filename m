Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSJXGPg>; Thu, 24 Oct 2002 02:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265327AbSJXGPf>; Thu, 24 Oct 2002 02:15:35 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:29454 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S265326AbSJXGPf>; Thu, 24 Oct 2002 02:15:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: One for the Security Guru's
Date: 24 Oct 2002 06:04:05 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ap82gl$2jh$1@abraham.cs.berkeley.edu>
References: <20021023130251.GF25422@rdlg.net>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1035439445 2673 128.32.153.211 (24 Oct 2002 06:04:05 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 24 Oct 2002 06:04:05 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
>  The consultants aparantly told the company admins that kernel modules
>were a massive security hole and extremely easy targets for root kits.

They were blowing smoke.  Once the attacker has root on your machine,
you're toast, whether or not you have loadable modules enabled.  The right
defense is to prevent attackers from getting root on your machine; the
consultant's recommendations are probably not the best way to spend your
time and energy.
