Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbTIMJtx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTIMJtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:49:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:4911 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262107AbTIMJtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:49:51 -0400
Date: Sat, 13 Sep 2003 10:48:41 +0100
From: Dave Jones <davej@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Xose Vazquez Perez <xose@wanadoo.es>, Tosatti <marcelo@cyclades.com.br>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci.ids 2.4.23-pre3
Message-ID: <20030913094841.GA29307@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Xose Vazquez Perez <xose@wanadoo.es>,
	Tosatti <marcelo@cyclades.com.br>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3F61FF67.7080504@wanadoo.es> <20030912224447.GA3917@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912224447.GA3917@werewolf.able.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 12:44:47AM +0200, J.A. Magallon wrote:

 > Changed to
 > 
 >     6325  SiS65x/M65x/740 PCI/AGP VGA Display Adapter
 >     0571  VT82C586x/C686x/33x/35 PIPC Bus Master IDE

The latter parts of these strings are redundant and can be
obtained by decoding other fields of the pci config header.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
