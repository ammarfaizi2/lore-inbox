Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVAaWih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVAaWih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVAaWih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:38:37 -0500
Received: from opersys.com ([64.40.108.71]:21773 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261411AbVAaWie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:38:34 -0500
Message-ID: <41FEB2A9.5050000@opersys.com>
Date: Mon, 31 Jan 2005 17:35:21 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
References: <16890.38062.477373.644205@tut.ibm.com> <20050129081527.GD7738@kroah.com> <41FEACD3.10502@opersys.com> <20050131223332.GA25419@kroah.com>
In-Reply-To: <20050131223332.GA25419@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> When relayfs is built into the kernel, those symbols are then global to
> the whole static kernel.
> 
> Please be nice and rename them.

My pleasure :)

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
