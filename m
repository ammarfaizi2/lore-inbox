Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUATV0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265797AbUATV0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:26:45 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:31843 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S265796AbUATV0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:26:44 -0500
Date: Tue, 20 Jan 2004 22:25:24 +0100
Message-Id: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@trabinski.net>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 5C87 7FF4 9539 6AA9 4EEF  529D 0236 ECCB 70F1 E978
X-Key-ID: 70F1E978
User-Agent: tin/1.7.3-20031220 ("Taransay") (UNIX) (Linux/2.4.25-pre6 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58L.0401161207000.28357@logos.cnet> you wrote:
> 
> Hi,
> 
> Here goes -pre6.
> 
> This release came out so quickly because -pre5 contains a deadly mistake
> in one of the fs patches.

SMP (2x2.66GHz Intel), with scsi aic79xx  with kernel -pre6 crashed after
3 days.

No ooops in logs files or console.
Output from console SysRq showTasks, showMem and showTasks you can see
here:

http://lukasz.eu.org/minicom.txt
or here, if first will not work:
http://www.pm.waw.pl/~lukasz/minicom.txt


-- 
*[ £T ]*
