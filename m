Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVJGQlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVJGQlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVJGQlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:41:04 -0400
Received: from cid.upcomillas.es ([130.206.70.227]:56267 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S1030501AbVJGQlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:41:03 -0400
Date: Fri, 7 Oct 2005 18:41:20 +0200
From: Romano Giannetti <romanol@upcomillas.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Instability in kernel version 2.6.12.5
Message-ID: <20051007164120.GA30623@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	linux-kernel@vger.kernel.org
References: <43455F33.7020102@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <43455F33.7020102@drexel.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 01:30:27PM -0400, Justin R. Smith wrote:
> 
> Examining the system logs disclosed that someone attempted to hack my 
> system at 2331 (the time the clock was frozen at) by trying to initiate 
> about 200 ssh connections with randomly generated user ids over a very 
> short time (a few seconds).
> 

Probably not the casue. It happens quite often here (followed by me doing a
iptable blocking on the IP and sending a reclamation to the preovider, with
no answer unfortunately) and I never saw problems like the one you describe. 

Version is Linux 2.6.11-12mdkcustom, but it happened with vanilla kernel(s)
too, same behavior here. 

HTH,
    Romano


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
