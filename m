Return-Path: <linux-kernel-owner+w=401wt.eu-S1161140AbXAMAmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbXAMAmo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 19:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbXAMAmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 19:42:44 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:60676 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161140AbXAMAmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 19:42:43 -0500
Message-ID: <45A82AFE.8060805@gmail.com>
Date: Sat, 13 Jan 2007 01:42:15 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Frederik Deweerdt <deweerdt@free.fr>, Len Brown <lenb@kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rui.zhang@intel.com, michal.k.k.piotrowski@gmail.com
Subject: Re: Early ACPI lockup (was Re: 2.6.20-rc4-mm1)
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112102040.GD5941@slug> <200701121753.08710.lenb@kernel.org> <20070112231015.GI5941@slug> <45A81B6C.3030106@gmail.com>
In-Reply-To: <45A81B6C.3030106@gmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>> On Fri, Jan 12, 2007 at 05:53:08PM -0500, Len Brown wrote:
>>> What do you see if on failure you also print out the params, like below?
[...]
> ACPI: acpi_table_parse(17, 00000000) HPET NULL handler!

After re-enabling HPET, it disappeared.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
