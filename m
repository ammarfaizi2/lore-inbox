Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272953AbTHKS7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273288AbTHKS5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:57:51 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:61147 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S273298AbTHKS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:57:07 -0400
Date: Mon, 11 Aug 2003 19:56:34 +0100
From: Dave Jones <davej@redhat.com>
To: Jocelyn Mayer <l_indien@magic.fr>
Cc: Greg KH <greg@kroah.com>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2 does not boot with matroxfb
Message-ID: <20030811185633.GA4237@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jocelyn Mayer <l_indien@magic.fr>, Greg KH <greg@kroah.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <1060429216.29152.61.camel@jma1.dev.netgem.com> <1060624865.29139.137.camel@jma1.dev.netgem.com> <20030811180703.GA1564@redhat.com> <20030811181414.GB17442@kroah.com> <1060628145.29139.164.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060628145.29139.164.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:55:45PM +0200, Jocelyn Mayer wrote:

 > > > Did you also compile in any of the AGP chipset drivers?
 > # CONFIG_AGP_AMD is not set

That'll be 'no' then 8-)
Fix this, and everything should start magickally working.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
