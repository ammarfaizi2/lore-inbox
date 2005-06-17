Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVFQJiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVFQJiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVFQJiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:38:21 -0400
Received: from main.gmane.org ([80.91.229.2]:27049 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261925AbVFQJiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:38:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Date: Fri, 17 Jun 2005 11:37:35 +0200
Message-ID: <yw1xoea5wcgw.fsf@ford.inprovide.com>
References: <yw1xslzl8g1q.fsf@ford.inprovide.com> <200506162118.18470.pmcfarland@downeast.net>
 <yw1xekb1xuk9.fsf@ford.inprovide.com>
 <200506170450.12943.pmcfarland@downeast.net>
 <yw1xy899wde4.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:MbVXFhROkq7DwKUe92Vsrcynuoc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like something ate the Hangul.  I'll try again, without any
other non-ascii characters.

>>> As for 50 bytes being too short, many of the multibyte characters are
>>> equivalent to several English characters, so fewer of them are
>>> required.  You have a point, though.
>>
>> Any English characters (ie, the first 127 ascii characters) map
>> directly to the first 127 Unicode characters (if thats what you
>> meant).
>
> Let me clarify with an example.  The common Korean name Kim consists
> of three ascii characters.  The Hangul spelling, 김, is encoded in
> utf-8 using three bytes.  Even though a three-byte character was used,
> the number of bytes is the same.

