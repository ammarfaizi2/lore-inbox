Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVAQU1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVAQU1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVAQU1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:27:16 -0500
Received: from opersys.com ([64.40.108.71]:46088 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262871AbVAQU1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:27:06 -0500
Message-ID: <41EC2157.1070504@opersys.com>
Date: Mon, 17 Jan 2005 15:34:31 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
References: <20050114002352.5a038710.akpm@osdl.org>	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>	 <41E8543A.8050304@am.sony.com>	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>	 <41E9EC5A.7070502@opersys.com>	 <1105919017.13265.275.camel@tglx.tec.linutronix.de>	 <41EB1AEC.3000106@opersys.com> <1105957604.13265.388.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105957604.13265.388.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> Thats the point. Adding another hardwired implementation does not give
> us a possibility to solve the hardwired problem of the already available
> stuff.

Well then, like I said before, you know what you need to do:
http://www-124.ibm.com/developerworks/oss/linux/projects/kernelhooks/

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
