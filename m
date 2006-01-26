Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWAZUm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWAZUm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWAZUm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:42:56 -0500
Received: from soohrt.org ([85.131.246.150]:29123 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S964871AbWAZUmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:42:55 -0500
Date: Thu, 26 Jan 2006 21:42:54 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in vsnprintf
Message-ID: <20060126204254.GC22994@quickstop.soohrt.org>
Mail-Followup-To: Nish Aravamudan <nish.aravamudan@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20060126195038.GB22994@quickstop.soohrt.org> <29495f1d0601261205u62aec435xfe6f94dc998934dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0601261205u62aec435xfe6f94dc998934dc@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Nish Aravamudan wrote:
> On 1/26/06, Horst Schirmeier <horst@schirmeier.com> wrote:
> > since I'm testing the 2.6.16 release candidate, I'm encountering the
> > following problem which manifests by a reported "Badness in vsnprintf"
> > in dmesg. The system is still usable after this event.
> 
> I think this is also discussed here
> http://lkml.org/lkml/2006/1/22/163. And there is a patch therein to
> fix it (http://lkml.org/lkml/2006/1/24/237).

Thanks, this resolves it temporarily.

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
