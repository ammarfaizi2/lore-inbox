Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423126AbWJVGza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423126AbWJVGza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 02:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423128AbWJVGza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 02:55:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:13659 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423126AbWJVGz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 02:55:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8SANi8nAEUc+oenfxnqTBdo2P+BecJ3aG0ihnTicXpitWEnzlJmykYux56lIk9H7M6Gsaib93RfOKqUlnKzOqXOI/lZJZQUQL896FYdF/If4/UGIuy9V0cNDCtAJDTDuPqfhLaEffkMUwZiaCWNWIVgDl9yTyR3v3vrmR+hgG8=
Message-ID: <86802c440610212355t237e171qf0dba82edc953066@mail.gmail.com>
Date: Sat, 21 Oct 2006 23:55:28 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>
In-Reply-To: <20061022035109.GM5211@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	 <20061022035109.GM5211@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can you try to add command line pci=routeirq?

also if put the driver in the kernel?

YH
