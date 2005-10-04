Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVJDN6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVJDN6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVJDN6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:58:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:17322 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932457AbVJDN57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:57:59 -0400
Date: Tue, 4 Oct 2005 08:57:48 -0500
From: serue@us.ibm.com
To: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@epoch.ncsc.mil>, gcwilson@us.ibm.com,
       James Morris <jmorris@redhat.com>
Subject: Re: The price of SELinux (CPU)
Message-ID: <20051004135748.GA7518@sergelap.austin.ibm.com>
References: <43421F46.8030202@comcast.net> <20051004065149.23426.qmail@web35505.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004065149.23426.qmail@web35505.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan C Marinescu (dan_c_marinescu@yahoo.com):
> John,
> 
> Try this link:
> 
> http://www.nsa.gov/selinux/list-archive/0505/11459.cfm
> 
> It's from NSA... Hope this helps somehow...

Note that these benchmarks were done quite some time ago.  Among
many other changes, selinux's memory overhead was recently significantly
reduced which should help these benchmarks quite a bit.

Hopefully we can do another round of benchmarks soon, but we were
waiting for particular machine to become available.

-serge
