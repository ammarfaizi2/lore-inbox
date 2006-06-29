Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932891AbWF2Lvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932891AbWF2Lvf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbWF2Lvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:51:35 -0400
Received: from mail.gmx.net ([213.165.64.21]:13014 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932891AbWF2Lve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:51:34 -0400
X-Authenticated: #342784
From: jensmh@gmx.de
To: Paolo Ornati <ornati@gmail.com>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Date: Thu, 29 Jun 2006 13:51:15 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
References: <20060629134002.1b06257c@localhost>
In-Reply-To: <20060629134002.1b06257c@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291351.18134.jensmh@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati writes:

> diff --git a/Documentation/DocBook/journal-api.tmpl b/Documentation/DocBook/journal-api.tmpl
> index 2077f9a..7937c98 100644
> --- a/Documentation/DocBook/journal-api.tmpl
> +++ b/Documentation/DocBook/journal-api.tmpl
> @@ -184,8 +184,8 @@ journal_start() so you can deadlock here
>  <para>
>  Try to reserve the right number of blocks the first time. ;-). This will
>  be the maximum number of blocks you are going to touch in this transaction.
> -I advise having a look at at least ext3_jbd.h to see the basis on which 
> -ext3 uses to make these decisions.

I think the old version is correct, isn't it?

> +I advise having a look at least ext3_jbd.h to see the basis on which ext3
> +uses to make these decisions.
>  </para>
