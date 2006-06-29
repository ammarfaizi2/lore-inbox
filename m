Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWF2OGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWF2OGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWF2OGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:06:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20783 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWF2OGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:06:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Qp2GqSUJdOSrpsfNeGdI4kNC2t2isM5ath6hIWv+nMqamP3mzOfUnKdQrSYBgrJuqmtAsQ69wH0yJdHwNyuTW4kmUxwbVlB14aCvsbrZtXkJdVj/yQNeszOGvMmJ2BuffiHeSWnwCV9BBDVCiJ98pEmQIQ3zNmbNV0XX2E0X4lc=
Date: Thu, 29 Jun 2006 16:06:11 +0200
From: Paolo Ornati <ornati@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: jensmh@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Message-ID: <20060629160611.73a90bf2@localhost>
In-Reply-To: <200606291435.39879.s0348365@sms.ed.ac.uk>
References: <20060629134002.1b06257c@localhost>
	<200606291339.11733.s0348365@sms.ed.ac.uk>
	<20060629150545.167c0abb@localhost>
	<200606291435.39879.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 14:35:39 +0100
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Actually the context made me think otherwise, look:
> 
> "Otherwise, statistics (average think time, average seek distance) on **the** 
> process that submitted the just completed.."

"the process" and "that process" are in two different periods, doesn't
it matter?

Otherwise,
 statistics (average think time, average seek distance) on **the process**
 that submitted the just completed request are examined**.**  If it seems
-likely that **that process** will submit another request soon, and that

In the second period "that process" refers clearly to "the process"
defined in the first period, while "process" looks pretty generic.

No?

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
