Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbTHLUnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271106AbTHLUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:43:46 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:18956 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S271105AbTHLUno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:43:44 -0400
Date: Tue, 12 Aug 2003 22:43:37 +0200
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030812204337.GA7893@gamma.logic.tuwien.ac.at>
References: <E19mZ7k-000LgM-00.arvidjaar-mail-ru@f13.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E19mZ7k-000LgM-00.arvidjaar-mail-ru@f13.mail.ru>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 12 Aug 2003, "Andrey Borzenkov"  wrote:
> > 	cannot mount rootfs "NULL" or hdb1
> > I have compile in (of course) the filesystems of my root fs (ext3)
> 
> and you have tried to add rootfstype=ext3?

Yes. No change. Also in combination with all root= options and also with
ext2.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCONSER (n.)
A person who looks around then when talking to you, to see if there's
anyone more interesting about.
			--- Douglas Adams, The Meaning of Liff
