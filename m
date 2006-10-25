Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWJYWZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWJYWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWJYWZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:25:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13758 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964876AbWJYWZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:25:55 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 01:25:38 +0300
Message-Id: <1161815138.27622.139.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 16:42 +0200, Shem Multinymous wrote:
> Hi,
> 
> On 10/25/06, David Woodhouse <dwmw2@infradead.org> wrote:
> > If you can summarise the bits I've missed in the meantime that would be
> > wonderfully useful
> 
> OK. Looking at the current git snapshot:
>  < ... >

Ok, thanks for the feedback -- I think I've done all that. It wasn't in
'diff -u' form so I may have misapplied it. Please confirm.

> I take it you don't want to deal with battery control actions for now.

They're simple enough to add. We can do it when the tp driver gets
converted over.

> I think using one set of files and units string makes more sense, for
> several reasons:

Yeah, OK. Colour me convinced. I'll leave it as I had it.

-- 
dwmw2

