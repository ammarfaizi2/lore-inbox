Return-Path: <linux-kernel-owner+w=401wt.eu-S1751457AbXAPUbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXAPUbr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXAPUbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:31:47 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:43557 "HELO
	smtp105.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751457AbXAPUbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:31:46 -0500
X-YMail-OSG: l.Fn_l0VM1ljqwjIQwR2v.OFiq80_vmVq8itdlyeI0Syk.yCL5nLkx3t7lsqGg8L8J7nKHlQh1HtQJiv_ic34RInoEctvD3dIvDjAKwefGlWHuSH8G5EMaJfJ7u2mivsGOrCjSqlQa8un.0-
Date: Tue, 16 Jan 2007 12:31:43 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, ak@suse.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Message-ID: <20070116203143.GA4213@tuatara.stupidest.org>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net> <45ACE07D.3050207@shaw.ca> <20070116180154.GA1335@tuatara.stupidest.org> <45AD2D00.2040904@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AD2D00.2040904@scientia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 08:52:32PM +0100, Christoph Anton Mitterer wrote:

> I agree,... it seems drastic, but this is the only really secure
> solution.

I'd like to here from Andi how he feels about this?  It seems like a
somewhat drastic solution in some ways given a lot of hardware doesn't
seem to be affected (or maybe in those cases it's just really hard to
hit, I don't know).

> Well we can hope that Nvidia will find out more (though I'm not too
> optimistic).

Ideally someone from AMD needs to look into this, if some mainboards
really never see this problem, then why is that?  Is there errata that
some BIOS/mainboard vendors are dealing with that others are not?

> But we should not forget about the issue, just because SATA is not
> longer affected.

Right.
