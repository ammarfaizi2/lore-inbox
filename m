Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWJAMyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWJAMyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJAMyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:54:38 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:59092 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932152AbWJAMyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:54:37 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Sun, 1 Oct 2006 15:54:59 +0300
User-Agent: KMail/1.9.4
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, mchehab@infradead.org
References: <200609150901.33644.ismail@pardus.org.tr> <200610011034.57158.ismail@pardus.org.tr> <20061001091411.GA9647@uranus.ravnborg.org>
In-Reply-To: <20061001091411.GA9647@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610011555.00345.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 12:14, Sam Ravnborg wrote:
[...]
> > Thanks, I will have a look at it.
>
> I assume you will same errors from the in-kernel modpost.
> If you do not do so then there is some inconsistency between depmod
> and modpost that ougth to be fixed.
>

I didn't see any errors when I did the build, I will try to reproduce and fix 
the issue.

Regards,
ismail
