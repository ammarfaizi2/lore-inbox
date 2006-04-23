Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWDWU2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWDWU2A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWDWU2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 16:28:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751380AbWDWU2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 16:28:00 -0400
Date: Sun, 23 Apr 2006 16:26:57 -0400
From: Dave Jones <davej@redhat.com>
To: Fernando Barsoba <fbarsoba@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: installing older kernel (2.4.20/28 on machine running 2.6.15)
Message-ID: <20060423202657.GD14680@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Fernando Barsoba <fbarsoba@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <20060423192949.GA13666@stusta.de> <BAY114-F395006CC148F4F61BFB684C7B90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY114-F395006CC148F4F61BFB684C7B90@phx.gbl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 03:39:23PM -0400, Fernando Barsoba wrote:
 > Adrian,
 > 
 > Thanks a lot for your answer. I am trying to install it on fedora 5. I 
 > guess i should ask fedora forum about this matter.

Give up now.  There's no static /dev, no 2.4 compatible modutils,
and a slew of other bits of userspace will be too new.

		Dave

-- 
http://www.codemonkey.org.uk
