Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVIQQsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVIQQsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 12:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVIQQsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 12:48:43 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:2314 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751153AbVIQQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 12:48:42 -0400
Date: Sat, 17 Sep 2005 12:48:31 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jack Steiner <steiner@sgi.com>
Cc: Greg KH <greg@kroah.com>, Tony Luck <tony.luck@gmail.com>,
       Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Message-ID: <20050917164829.GD19854@tuxdriver.com>
Mail-Followup-To: Jack Steiner <steiner@sgi.com>, Greg KH <greg@kroah.com>,
	Tony Luck <tony.luck@gmail.com>, Keith Owens <kaos@sgi.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20050913065937.GA7849@kroah.com> <25288.1126596450@kao2.melbourne.sgi.com> <12c511ca05091708476aa136cd@mail.gmail.com> <20050917155911.GB19854@tuxdriver.com> <20050917161617.GA23171@kroah.com> <20050917163434.GB24322@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917163434.GB24322@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 11:34:34AM -0500, Jack Steiner wrote:

> We are working on an SN-only workaround. No guarantee, but the person
> working on it is optimistic that we can fix the problem in SN code
> w/o making any generic changes. I should know more on Monday.
> 
> Long term, we are making SN ACPI compliant - or at leeast a lot closer.

Well, there you go... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
