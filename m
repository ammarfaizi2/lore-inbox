Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUJOPMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUJOPMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUJOPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:10:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:8621 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268008AbUJOPI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:08:28 -0400
Message-ID: <416FE5E6.3000309@osdl.org>
Date: Fri, 15 Oct 2004 07:59:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lsml@rtr.ca>,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH] Export ata_scsi_simulate() for use by non-libata drivers
References: <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca> <416DAF1A.2040204@pobox.com> <416DB912.7040805@rtr.ca> <416DBC96.2090602@pobox.com> <416EA996.4040402@rtr.ca> <416EAECC.7070000@rtr.ca> <416EB1B6.5070603@pobox.com> <416EC90A.30607@rtr.ca> <416F5A72.9080602@pobox.com> <20041015092535.C25937@tuxdriver.com>
In-Reply-To: <20041015092535.C25937@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Fri, Oct 15, 2004 at 01:04:50AM -0400, Jeff Garzik wrote:
> 
>>The full body of your email is pasted into the BitKeeper changeset 
>>description.
> 
> 
> Jeff,
> 
> Andrews "The perfect patch"
> (http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt) in section
> 3.e says: 
> 
>    Most people's patch receiving scripts will treat a ^--- string
>    as the separator between the changelog and the patch itself.  You can
>    use this to ensure that any diffstat information is discarded when the
>    patch is applied:
> 
> Do your scripts act this way as well?

Jeff, are your scripts available somewhere (for the rest of us)?

> It is nice to be able to send a single e-mail both w/
> changelog-appropriate comments and with "this relates to the last
> message" comments as well...
> 
> John
> 
> P.S.  Hopefully I didn't misunderstand Andrew...


Thanks,
-- 
~Randy
