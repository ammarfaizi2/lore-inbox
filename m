Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTDMRU0 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 13:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTDMRU0 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 13:20:26 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:8207
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263552AbTDMRUZ 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 13:20:25 -0400
Subject: Re: 2.5.67: ppa driver & preempt == oops
From: Robert Love <rml@tech9.net>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E993C54.40805@hccnet.nl>
References: <3E982AAC.3060606@hccnet.nl>
	 <1050172083.2291.459.camel@localhost>  <3E993C54.40805@hccnet.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1050255133.733.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 13:32:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 06:30, Gert Vervoort wrote:


> With 2.5.67 it is just these messages, the system continues working. 
> Because of these messages I've not tried if the zip-driver functions 
> properly.

The bug has probably been there forever, it is just that only now we can
detect it.

So your zip drive most likely works fine.

Try the patch Andrew posted.

	Robert Love

