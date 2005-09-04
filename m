Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVIDJQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVIDJQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 05:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIDJQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 05:16:18 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:30833
	"HELO fargo") by vger.kernel.org with SMTP id S1751308AbVIDJQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 05:16:17 -0400
Date: Sun, 4 Sep 2005 11:10:12 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: Brand-new notebook useless with Linux...
Message-ID: <20050904091012.GA4394@fargo>
Mail-Followup-To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel@vger.kernel.org
References: <200509031859_MC3-1-A720-F705@compuserve.com> <E1EBje3-0002GW-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EBje3-0002GW-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 04 at 02:50:07, Matthew Garrett wrote:
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > SMBus
> 
> Is there anything on there that you actually want to talk to?

Smart batteries are accesed thru the SMBus. If you want to know
battery information, like the charge, you need to talk to the SMBus.

There are some patches out there, not integrated yet into ACPI
i think...

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
