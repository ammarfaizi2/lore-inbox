Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWF2L6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWF2L6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWF2L6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:58:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:57874 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWF2L6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:58:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XUszhgj//Pqt6suQbBcxYWnSPtkVQGLpu8zSsUQHbhtmSeHNj/nd708hh+Z0X07e8ospF+RCE/UuSgFFCGB0vV1g1QNhPNZ3pKOyXgB4iXpZ6vDBnI63u6NN1KicnY50L1i5rmtvTMHJ/8KwPA74MXknq8A6p63PgJz1vDv/Ym4=
Date: Thu, 29 Jun 2006 13:58:33 +0200
From: Paolo Ornati <ornati@gmail.com>
To: jensmh@gmx.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Message-ID: <20060629135833.395d95d6@localhost>
In-Reply-To: <200606291351.18134.jensmh@gmx.de>
References: <20060629134002.1b06257c@localhost>
	<200606291351.18134.jensmh@gmx.de>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:51:15 +0200
jensmh@gmx.de wrote:

> > -I advise having a look at at least ext3_jbd.h to see the basis on which 
> > -ext3 uses to make these decisions.
> 
> I think the old version is correct, isn't it?

Ahh, yes... thanks!

I'll wait to see if someone spot something else then resend.

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
