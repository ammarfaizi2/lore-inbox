Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTKCNZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTKCNZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:25:41 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:64904 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261881AbTKCNZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:25:40 -0500
Date: Mon, 3 Nov 2003 13:24:09 +0000
From: Dave Jones <davej@redhat.com>
To: Geoffrey Lee <glee@gnupilgrims.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031103132409.GA25183@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Geoffrey Lee <glee@gnupilgrims.org>, linux-kernel@vger.kernel.org
References: <20031102055748.GA1218@anakin.wychk.org> <20031102125202.GA7992@redhat.com> <20031103092048.GB14080@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103092048.GB14080@anakin.wychk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 05:20:48PM +0800, Geoffrey Lee wrote:

 > Would checking boot_cpu_data.x86_vendor == X86_VENDOR_AMD and 
 > boot_cpu_data.x86 == 6 be sufficient?  It seems to do the right thing ..
 > Updated patch attached.

Yup, looks to be pretty much the same change I made in my local tree.

		Dave

