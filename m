Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936967AbWLFSAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936967AbWLFSAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936972AbWLFSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:00:50 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:28393 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S936967AbWLFSAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:00:50 -0500
X-YMail-OSG: Cygc52wVM1kMqSIA9_bSxG2wUCFY6vX9Ab7QBs6DotfDdMPNm7wyP.i24aDrA_H.2rD0Cs2UOixeBv9vS89K5Hm8uMcHvsEpne3Hv7PyJn2T17N0GUZG6HkfWheuWlUeRWz2oprwpjxg5g--
Date: Wed, 6 Dec 2006 10:00:47 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: rdunlap@xenotime.net, gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Change x86 prefix order
Message-ID: <20061206180047.GA810@lucon.org>
References: <200612061752.kB6Hqd1J004450@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061752.kB6Hqd1J004450@harpo.it.uu.se>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 06:52:39PM +0100, Mikael Pettersson wrote:
> 
> If hardware x86 decoders (i.e., Intel or AMD processors)
> get measurably faster with the new order, that would be
> a good reason to change it.

I was told that AMD processors had no preferences and Intel processors
preferred the proposed order.


H.J.
