Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWFOHn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWFOHn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFOHn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:43:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:53601 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751044AbWFOHn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:43:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SqwdodUGCGpBWHeolOLOkJ8Aa4ABR2h3vjp01bEy7xpPgs71PROoPGkbuuaHkTwiw7pLEXYdVZv/UAb8Os7p/fWKDCRDv/40Chdu1Wh5wZFYZKKAovWJJITIRKDluYaMB9ynyWC7HNSW//waDRT1hA/JhBMJC8rImkJR0TnBxyg=
Message-ID: <986ed62e0606150043i71b37d0am3acc18697db4760c@mail.gmail.com>
Date: Thu, 15 Jun 2006 00:43:25 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Theodore Tso" <tytso@mit.edu>, "Barry K. Nathan" <barryn@pobox.com>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060615045550.GB7318@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m3irnacohp.fsf@bzzz.home.net> <m3ac8mcnye.fsf@bzzz.home.net>
	 <4489B83E.9090104@sbcglobal.net>
	 <20060609181426.GC5964@schatzie.adilger.int>
	 <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz>
	 <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com>
	 <20060614213431.GF4950@ucw.cz>
	 <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
	 <20060615045550.GB7318@thunk.org>
X-Google-Sender-Auth: 35394457af048d70
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/06, Theodore Tso <tytso@mit.edu> wrote:
> Please try it with 1.39; if it still crashes, let me know --- I treat
[snip]

1.39 fixes it. Cool!

However, http://e2fsprogs.sourceforge.net/ is still touting the "NEW"
e2fsprogs 1.38 release. I think it would be a good idea to update the
page...
-- 
-Barry K. Nathan <barryn@pobox.com>
