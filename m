Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWJLERe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJLERe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 00:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWJLERe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 00:17:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27578 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965223AbWJLERd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 00:17:33 -0400
Date: Wed, 11 Oct 2006 21:17:21 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: greg@kroah.com, menage@google.com, ckrm-tech@lists.sourceforge.net,
       matthltc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061011211721.7c9af71e.pj@sgi.com>
In-Reply-To: <1160609160.6389.80.camel@linuxchandra>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011223927.GA29943@kroah.com>
	<1160609160.6389.80.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree.  You are trying to use configfs for something that it is not
> entended to be used for.

Yup - but perhaps the best answer is that the design should be
extended, to handle a simple vector, such as a list of task process
id's or a list of CPU numbers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
