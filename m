Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVEYHEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVEYHEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 03:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVEYHB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 03:01:28 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44756 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262303AbVEYGzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:55:25 -0400
Date: Wed, 25 May 2005 12:23:48 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Nagesh Sharyathi <sharyathi@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       mjbligh <Martin.Bligh@us.ibm.com>
Subject: Re: [Fastboot] kdump test update
Message-ID: <20050525065348.GB3937@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <OFA0D3C130.0ED83C93-ON6525700B.0030EAEB-6525700B.0032C0D5@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA0D3C130.0ED83C93-ON6525700B.0030EAEB-6525700B.0032C0D5@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 02:38:42PM +0530, Nagesh Sharyathi wrote:
> These I have tested on the kernel 2.6.12-rc4-mm1 with the following test
> suites , with kdump enabled 
> 

Thanks for doing this, but it will be nice if you could also verify the
dumps using gdb. I have anyway added these test reportd on kdump test webpage at

  http://lse.sourceforge.net/kdump/kdump-test.html

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
