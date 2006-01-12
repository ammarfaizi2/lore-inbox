Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWALH7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWALH7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWALH7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:59:13 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:1772 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932121AbWALH7N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:59:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ezyeAeFVkDzEM0rNLU8iAJ83C3cbAHCmzOvc6M3I4tffEW4G0nwZmpTxb6ruTVwbpjvPXGtEDhgPaKWaBsgE3z5tP7ZbSfwZhr/1Udti1x1/XLmtNXti9XkUu9qpZduQgBF/WdUUAXRb9kbMeqReoUNA+YxfoIRKZ3JMaVoMUQE=
Message-ID: <7e5f60720601112359k181af0b1pae8068b05bc72a3b@mail.gmail.com>
Date: Thu, 12 Jan 2006 08:59:12 +0100
From: Peter Bortas <bortas@gmail.com>
To: Weber Ress <ress.weber@gmail.com>
Subject: Re: Kernel Education
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9c2327970601111042i126c7dfbk10aa2bd35310b6c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c2327970601090500i78fec178mb197c0fa5732e4a4@mail.gmail.com>
	 <Pine.LNX.4.61.0601090805140.17451@chaos.analogic.com>
	 <9c2327970601111042i126c7dfbk10aa2bd35310b6c3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Weber Ress <ress.weber@gmail.com> wrote:
> Somebody knows the Nachos? http://www.cs.washington.edu/homes/tom/nachos/
>
> Is a good idea use this software in my educational project ?

Not really. You student will spend more time working around and fixing
the framework than they will be doing OS development. That in it self
might be educational, but not so much for becoming a better OS
builder.

--
Peter Bortas
