Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTALJyy>; Sun, 12 Jan 2003 04:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTALJyy>; Sun, 12 Jan 2003 04:54:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:38028 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267346AbTALJyx>; Sun, 12 Jan 2003 04:54:53 -0500
Date: Sun, 12 Jan 2003 11:03:35 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: more thoughts on kernel config organization
Message-ID: <20030112100335.GE11450@louise.pinerecords.com>
References: <20030112080406.GA1006@mars.ravnborg.org> <Pine.LNX.4.44.0301120421010.24231-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301120421010.24231-100000@dell>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
> 
> a couple hours ago, i posted an alternate fs/Kconfig file, but i haven't 
> seen it appear on the mailing list.  is there a size limit for postings?
> is there another way to make it available for anyone who wants to check
> it out?

Make the re-arranged Kconfig a unidiff against latest bk, check that
everything compiles as expected and send it here.  If the diff turns
out large (it probably will), gzip it.

-- 
Tomas Szepe <szepe@pinerecords.com>
